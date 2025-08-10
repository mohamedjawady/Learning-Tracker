class PdfFileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w(pdf)
  end

  def content_type_allowlist
    ['application/pdf']
  end

  def filename
    "#{model.title.parameterize}.pdf" if original_filename
  end
end
