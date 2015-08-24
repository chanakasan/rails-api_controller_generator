<% module_namespacing do -%>
class API::<%= controller_class_name %>Controller < API::BaseController
  # list
  def index
    begin
      send_success(find_all)
    rescue Exception => e
      send_errors([e.message], 500)
    end
  end

  # get
  def show
    begin
      send_success(find)
    rescue ActiveRecord::RecordNotFound
      send_not_found
    end
  end

  # insert
  def create
    begin
      <%= singular_table_name %> = new_announcement
      <%= singular_table_name %>.save!

      send_success({id: <%= singular_table_name %>.id}, 201)
    rescue ActiveRecord::RecordInvalid
      send_errors(<%= singular_table_name %>.errors)
    rescue ActiveRecord::RecordNotFound => e
      send_errors([e.message])
    end
  end

  # patch
  def update
    begin
      <%= singular_table_name %> = find
      <%= singular_table_name %>.update!(resource_params)

      send_success(<%= singular_table_name %>)
    rescue ActiveRecord::RecordNotFound
      send_not_found
    rescue ActiveRecord::RecordInvalid
      send_errors(<%= singular_table_name %>.errors)
    rescue ActiveRecord::RecordNotFound => e
      send_errors([e.message])
    end
  end

  # delete
  def destroy
    begin
      <%= singular_table_name %> = find
      <%= singular_table_name %>.destroy

      send_no_content
    rescue ActiveRecord::RecordNotFound
      send_not_found
    end
  end

  private
  def resource_params
    params.require(:<%= singular_table_name %>).permit!
  end

  def find_all
    <%= orm_class.all(class_name) %>
  end

  def find
    <%= orm_class.find(class_name, "params[:id]") %>
  end

  def new_<%= singular_table_name %>
    <%= orm_class.build(class_name, "resource_params") %>
  end
end
<% end -%>
