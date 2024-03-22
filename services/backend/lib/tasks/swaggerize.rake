desc 'wrapper for rswag to fix schema pathing'
task swaggerize: ['rswag:specs:swaggerize'] do
  Dir.glob('swagger/v*/swagger.yaml').each do |file_path|
    new_text = File.read(file_path).gsub(%r{swagger/.*/schemas}, 'schemas')
    File.write(file_path, new_text)
  end
end
