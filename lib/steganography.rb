# Code taken from https://gist.github.com/esoterik/317e2fa12fff5a5f73f0839a71dfaab4
# NOTE: Present a full attribution in the README

require 'rmagick'
require 'chunky_png'

class Steganography
  include ChunkyPNG

  # the filename is the file with the full path
  def initialize(filename:)
	@filename = convert_to_png(filename)
	@img = Image.from_file(@filename) 
	@delim = "@$"
  end

  def to_s
	"Steganography: {#{@filename}}"
  end

  # Monkey patch for irb 
  # https://stackoverflow.com/questions/47252220/how-to-make-irb-not-printing-objects-attribute
  def inspect
	to_s
  end

  # the stego_filename is the file with the full path
  def encode(message:, stego_filename:)
	message = message.force_encoding('UTF-8')
	unless message.ascii_only?
		raise SteganographyException.new "Non-ascii characters in the message"
	end

	message = @delim + message + @delim
	binary_message = message.unpack('B*')[0].split(//).map(&:to_i)

	if img.area < binary_message.size
	  raise SteganographyException.new "Message requires #{binary_message.size} pixels to encode and the "\
		"image contains only #{img.area} pixels."
	end

	binary_message += [0] * (img.area - binary_message.size)

	img.height.times do |y|
	  img.width.times do |x|
		img[x, y] = encode_pixel(img[x, y],
								 binary_message[y * img.width + x])
	  end
	end

	img.save(stego_filename)

	return 0
  end

  def decode
	message = []
	img.height.times do |y|
	  img.width.times do |x|
		message << (Color.r(img[x, y]) % 2)
	  end
	end

	message = message.each_slice(8)
					 .map { |s| s.map(&:to_s).join('') }
					 .map { |s| [s].pack('B*') }.join('')

	message.split(@delim)[1]
  end

  private

  attr_reader :img, :filename, :delim

  def convert_to_png(file)
	return file if file.split('.')[1] == 'png'
	img = Magick::Image.read(file)[0]
	img.format = 'png'
	png_name = file.split('.')[0] + '.png'
	img.write(png_name)
	png_name
  end

  def encode_pixel(pixel, bit)
	return pixel if (Color.r(pixel) + bit) % 2 == 0
	Color.rgba(Color.r(pixel) + 1, Color.g(pixel),
			   Color.b(pixel), Color.a(pixel))
  end
end
