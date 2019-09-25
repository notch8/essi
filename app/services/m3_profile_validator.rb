class M3ProfileValidator

  def self.validate(data:, schema:, logger:)
    result = schema.validate(data.deep_stringify_keys)
    valid  = schema.valid?(data.deep_stringify_keys)

    logger.info("Data valid? #{valid}")

    if valid
      return true
    else
      result&.to_a&.each do |error|
        logger.error("\nError:")
        logger.error("\s\sType: #{error['type']}")
        logger.error("\s\sDetails: #{error['details']}")
        logger.error("\nMore error information:")
        logger.error("\s\sData pointer: #{error['data_pointer']}")
        logger.error("\s\sData: #{error['data']}\n")
        logger.error("\s\sSchema pointer: #{error['schema_pointer']}")
        logger.error("\s\sSchema: #{error['schema']}\n")
      end
      raise M3ValidatorError
    end

    valid
  end

  private

    class M3ValidatorError < StandardError
      def message
        'Data failed to validate against schema'
      end
    end
end
