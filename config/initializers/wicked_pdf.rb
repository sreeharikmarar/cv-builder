# wkhtml2pdf Ruby interface
# http://code.google.com/p/wkhtmltopdf/
#

# For heroku
#if Rails.env.production?
#    wkhtmltopdf_path = "#{Rails.root}/bin/wkhtmltopdf-amd64"
#else
#    wkhtmltopdf_path = "#{Rails.root}/bin/wkhtmltopdf-amd64"
#end

#WickedPdf.config = {
#
#      :exe_path     => wkhtmltopdf_path,
#      :wkhtmltopdf  => wkhtmltopdf_path
#
#  }


# For Local

class WickedPdf
  if Rails.env.production?
    wkhtmltopdf_path = "#{Rails.root}/bin/wkhtmltopdf-amd64"
  else
    wkhtmltopdf_path = "#{Rails.root}/bin/wkhtmltopdf-amd64"
  end
  WICKED_PDF = {
    :exe_path => wkhtmltopdf_path,
    :wkhtmltopdf => wkhtmltopdf_path
  }
end
