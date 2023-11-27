require 'nokogiri'

class ChislaResultsController < ApplicationController
  before_action :set_chisla_result, only: %i[ show edit update destroy ]

  # GET /chisla_results or /chisla_results.json
  XSLT_TRANSFORM = "#{Rails.root}/public/some_transformer.xslt".freeze # Путь до xslt файла
  # Добавить действие в контроллер, позволяющее определить, что хранится в БД через сериализацию в XML.
  def index
    @chisla_results = ChislaResult.all
  end

  #http://127.0.0.1:3000/show_all.xml
  def show_all
      respond_to do |format|
        results = ChislaResult.all
        rows = ''
        results.each do |record|
          rows += "<cd><former>#{record.string}</former><res_string>#{record.result}</res_string><my_t>#{record.my_table}</my_t></cd>"
        end
        responce = "<catalog>#{rows}</catalog>"
        format.xml { render xml: xslt_transform(responce).to_xml }
      end
  end

  def xslt_transform(data, transform: XSLT_TRANSFORM)
    # Функция преобразования
    pp 'checkpoint2'
    print data, transform, "\n"
    doc = Nokogiri::XML(data)
    xslt = Nokogiri::XSLT(File.read(transform))
    xslt.transform(doc)
  end

  # GET /chisla_results/1 or /chisla_results/1.json
  def show
  end

  # GET /chisla_results/new
  def new
    @chisla_result = ChislaResult.new
  end

  # GET /chisla_results/1/edit
  def edit
  end

  # POST /chisla_results or /chisla_results.json
  def create
    @chisla_result = ChislaResult.new(chisla_result_params)

    respond_to do |format|
      if @chisla_result.save
        format.html { redirect_to chisla_result_url(@chisla_result), notice: "Chisla result was successfully created." }
        format.json { render :show, status: :created, location: @chisla_result }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chisla_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chisla_results/1 or /chisla_results/1.json
  def update
    respond_to do |format|
      if @chisla_result.update(chisla_result_params)
        format.html { redirect_to chisla_result_url(@chisla_result), notice: "Chisla result was successfully updated." }
        format.json { render :show, status: :ok, location: @chisla_result }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chisla_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chisla_results/1 or /chisla_results/1.json
  def destroy
    @chisla_result.destroy

    respond_to do |format|
      format.html { redirect_to chisla_results_url, notice: "Chisla result was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chisla_result
    @chisla_result = ChislaResult.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def chisla_result_params
    params.require(:chisla_result).permit(:string, :result, :my_table)
  end
end
