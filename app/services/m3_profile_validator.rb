class M3ProfileValidator

  def self.validate(data:, schema:, logger:)
    schema.validate(data)
  end

end
