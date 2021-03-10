require 'spec_helper'
require 'rails_helper'

require 'steganography'
require 'steganography_ex'

puts "----> Steg spec path: #{File.expand_path File.dirname(__FILE__)}"
puts "----> Test cases in steg may take some time due to the processing involved"

test_source_filename = "#{File.expand_path File.dirname(__FILE__)}/../support/ms.png"
test_steg_filename = "#{File.expand_path File.dirname(__FILE__)}/../support/ms_steg.png"
small_img_filename = "#{File.expand_path File.dirname(__FILE__)}/../support/1x1.png"
small_img_steg_filename = "#{File.expand_path File.dirname(__FILE__)}/../support/1x1_steg.png"

describe "While applying Steganography" do
    context "when the ascii message and image are passed" do
        it "encodes and decodes properly" do
            m = "hello test"
            steg = Steganography.new(filename: test_source_filename)
            steg.encode(message: m, stego_filename: test_steg_filename)
            
            steg = Steganography.new(filename: test_steg_filename)
            text = steg.decode()
            expect(text).to eq(m)
        end
    end

    context "when non-ascii message and image are passed" do
        it "throws an exception" do
            m = "भारत"
            steg = Steganography.new(filename: test_source_filename)
            expect { 
                steg.encode(message: m, stego_filename: test_steg_filename)
        }.to raise_error(SteganographyException)
        end
    end

    context "when asii message bigger than image is passed" do
        it "throws an exception" do
            m = "hello test"
            steg = Steganography.new(filename: small_img_filename)
            expect { 
                steg.encode(message: m, stego_filename: small_img_steg_filename)
        }.to raise_error(SteganographyException)
        end
    end
end 