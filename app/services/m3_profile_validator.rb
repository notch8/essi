class M3ProfileValidator

  def self.call(data:, schema:, logger:)
    schema.validate(data)
  end

end
