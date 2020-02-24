class ArmorController < ApplicationController
  before_action :set_armor, only: [:show, :edit, :update, :destroy]

  # GET /armor
  # GET /armor.json
  def index
    @armor = Armor.all
    @magic_armor = MagicItem.armor.sort_by(&:name)
  end

  # GET /armor/1
  # GET /armor/1.json
  def show
  end

  # GET /armor/new
  def new
    @armor = Armor.new
  end

  # GET /armor/1/edit
  def edit
  end

  # POST /armor
  # POST /armor.json
  def create
    @armor = Armor.new(armor_params)

    respond_to do |format|
      if @armor.save
        format.html { redirect_to @armor, notice: 'Armor was successfully created.' }
        format.json { render :show, status: :created, location: @armor }
      else
        format.html { render :new }
        format.json { render json: @armor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /armor/1
  # PATCH/PUT /armor/1.json
  def update
    respond_to do |format|
      if @armor.update(armor_params)
        format.html { redirect_to @armor, notice: 'Armor was successfully updated.' }
        format.json { render :show, status: :ok, location: @armor }
      else
        format.html { render :edit }
        format.json { render json: @armor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /armor/1
  # DELETE /armor/1.json
  def destroy
    @armor.destroy
    respond_to do |format|
      format.html { redirect_to armor_index_url, notice: 'Armor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_armor
      @armor = Armor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def armor_params
      params.require(:armor).permit(:name, :armor_type, :ac, :strength_requirement, :stealth_disadvantage, :weight, :value, :description)
    end
end
