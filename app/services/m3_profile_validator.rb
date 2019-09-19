class M3ProfileValidator

  def self.validate(data:, schema:, logger:)
    result = schema.validate(data)
    valid = schema.valid?(data)

    logger.info("Data valid? #{valid}")

    if valid
      return true
    else
      result&.to_a&.each do |error|
        logger.info("\nData: #{error['data']}\n")
        logger.info("Data pointer: #{error['data_pointer']}\n")
        logger.info("Schema: #{error['schema']}\n")
        logger.info("Schema pointer: #{error['schema_pointer']}\n")
        logger.info("Type: #{error['type']}\n")
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
