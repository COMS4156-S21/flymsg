class SteganographyException < StandardError
    def initialize(msg="SteganographyException")
        @exception_type = "custom"
        super(msg)
    end
end