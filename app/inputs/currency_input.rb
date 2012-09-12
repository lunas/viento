
class CurrencyInput < SimpleForm::Inputs::Base
  def input
    super
    "$ #{@builder.text_field(attribute_name, input_html_options)}".html_safe
  end
end
