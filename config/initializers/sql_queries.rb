# Adds instrumentation for logging the number of SQL queries performed during a
# request. Largely based on [sql_queries_count][0], but kept internal for more
# control over formatting and naming.
#
# [0]: https://github.com/comboy/sql_queries_count
module SQLQueryCount
  module Instrumentation
    class Counter < ActiveSupport::LogSubscriber
      def self.counter=(value)
        Thread.current['sql_count'] = value
      end

      def self.counter
        Thread.current['sql_count'] ||= 0
      end

      def self.reset_counter
        new_count, self.counter = counter, 0
        new_count
      end

      def sql(_event)
        self.class.counter += 1
      end
    end

    module ControllerRuntime
      extend ActiveSupport::Concern

      attr_internal :db_runtime

      def process_action(action, *args)
        Counter.reset_counter

        super
      end

      def append_info_to_payload(payload)
        super

        if ActiveRecord::Base.connected?
          payload[:db_query_count] = Counter.reset_counter
        end
      end

      module ClassMethods
        def log_process_action(payload)
          messages, sql_count = super, payload[:db_query_count]
          messages << ("SQL Queries: %d" % sql_count) if sql_count
          messages
        end
      end
    end
  end
end

SQLQueryCount::Instrumentation::Counter.attach_to :active_record

ActiveSupport.on_load(:action_controller) do
  include SQLQueryCount::Instrumentation::ControllerRuntime
end
