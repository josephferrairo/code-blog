module TrixHelpers
  def fill_in_trix_editor(text="Added Text")
    execute_script("document.querySelector('trix-editor').editor.loadHTML('')")
    execute_script("document.querySelector('trix-editor').editor.insertString('#{text}')")
  end

  def strip_html(string)
    Nokogiri::HTML(string).text
  end
end
