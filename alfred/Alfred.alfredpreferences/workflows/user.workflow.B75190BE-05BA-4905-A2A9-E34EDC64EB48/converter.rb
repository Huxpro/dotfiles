class Item
	def initialize(uid, arg, title, subtitle='')
		@uid = uid
		@arg = arg
		@title = title
		@subtitle = subtitle
	end

	def to_xml
		o = "<item uid=\"#@uid\" arg=\"#@arg\">"
		o+= "<title>#{@title}</title>"
		o+= "<subtitle>#{@subtitle}</subtitle>"
		o+= "<icon>icon.png</icon>"
		o+= "</item>"
		puts o
	end
end

ascii = [
	"NUL (null)",
	"SOH (start of heading)",
	"STX (start of text)",
	"ETX (end of text)",
	"EOT (end of transmission)",
	"ENQ (enquiry)",
	"ACK (acknowledge)",
	"BEL (bell)",
	"BS (backspace)",
	"TAB (horizontal tab)",
	"LF (line feed, new line)",
	"VT (vertical tab)",
	"FF (form feed, new page)",
	"CR (carriage return)",
	"SO (shift out)",
	"SI (shift in)",
	"DLE (data link escape)",
	"DC1 (device control 1)",
	"DC2 (device control 2)",
	"DC3 (device control 3)",
	"DC4 (device control 4)",
	"NAK (negative acknowledge)",
	"SYN (synchronous idle)",
	"ETB (end of trans. block)",
	"CAN (cancel)",
	"EM (end of medium)",
	"SUB (substitute)",
	"ESC (escape)",
	"FS (file seperator)",
	"GS (group separator)",
	"RS (record separator)",
	"US (unit separator)"
]

items = []

query = ARGV.join(" ")
begin
	query = "0" + query if query.start_with? "b"
	i = Integer(query)

	return if i < 0

	items << Item.new("bin", i.to_s(2), i.to_s(2), "Binary")
	items << Item.new("oct", "0"+i.to_s(8), "0"+i.to_s(8), "Octagonal")
	items << Item.new("dec", i, i, "Decimal")
	items << Item.new("hex", "0x"+i.to_s(16), "0x"+i.to_s(16), "Hexadecimal")
	if i < 32
		items << Item.new("chr", ascii[i], ascii[i], "ASCII")
	elsif i < 128
		items << Item.new("chr", i.chr('UTF-8'), i.chr('UTF-8'), "ASCII")
	elsif i < 256
		items << Item.new("chr", i.chr('UTF-8'), i.chr('UTF-8'), "ASCII (extended)")
	end
rescue
	items << Item.new("error", query, "Could not convert number", "Invalid format")
end

puts "<items>"
items.each(&:to_xml)
puts "</items>"
