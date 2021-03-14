require 'constants'

Rails.application.config.after_initialize do
    Dir.mkdir(STEG_IMG_STORAGE) unless Dir.exist?(STEG_IMG_STORAGE)
    Dir.mkdir(IMG_STORAGE) unless Dir.exist?(IMG_STORAGE)  
end