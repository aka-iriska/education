require 'nokogiri'

doc = Nokogiri::XML(File.read('some_file.xml'))
xslt = Nokogiri::XSLT(File.read('public/some_transformer.xslt'))

puts xslt.transform(doc)