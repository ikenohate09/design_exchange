class CaseStudiesController < ApplicationController
  def index
    # @case_studies = CaseStudy.where("description != ?", "No description available" ).take(24)
    @case_studies = CaseStudy.take(24)
  	render layout: "wide"
  end

  def new
    id = params[:id] == nil ? 1 : params[:id].to_i
    # render :text => id
    @cs = CaseStudy.where("id=?", id).first;

    @attr = CaseStudy.columns_hash;
    @company = @cs.company
    @contacts = @company.contacts
    @methods = @cs.design_methods.reverse;
    @options = CaseStudy.options
    @helper_text = CaseStudy.helper_text()

    render :layout => "custom"
  end

  def edit
    id = params[:id] == nil ? 1 : params[:id].to_i
    # render :text => id
    @cs = CaseStudy.where("id=?", id).first;
    @case_study = CaseStudy.find(params[:id])
    
    @attr = CaseStudy.columns_hash;
    @company = @case_study.company
    @contacts = @company.contacts
    @methods = @case_study.design_methods().reverse;
    @options = CaseStudy.options
    @helper_text = CaseStudy.helper_text

    render :layout => "custom"
  end

  def show
    id = params[:id].to_i
    @case_study = CaseStudy.find(id)
    @author = @case_study.company.name
    @similar_methods = @case_study.similar_methods(100,6)
    @similar_case_studies = @case_study.similar_case_studies(100,6)
    @lookup = CaseStudy.lookup
    render layout: "custom"
    # render :json =>  @lookup
  end

  def search
  end

  def update
    @case_study = CaseStudy.find(params[:id])

    respond_to do |format|
      if @case_study.update_attributes(params[:case_study])
        format.html { redirect_to @case_study, notice: 'Case study was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @case_study.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @case_study = CaseStudy.new(params[:case_study])

    respond_to do |format|
      if @design_method.save
        format.html { redirect_to @case_study, notice: 'Case study was successfully created.' }
        format.json { render json: @case_study, status: :created, location: @case_study }
      else
        format.html { render action: "new" }
        format.json { render json: @case_study.errors, status: :unprocessable_entity }
      end
    end
  end

end
