
def pipe_to_comma(line) 
	line.gsub!(/[\r\n]/, '').gsub!(/^\"/, '').gsub!(/\"$/, '') # 양끝 큰따옴표 제거
	puts line
	tweet = line.split("||,||") # 구분자로 나눔
	# tweet.delete_at(-1) # 의견 제거
	tweet.each do |i|
    i.insert(0, '"').insert(-1, '"')
  end
	tweet.join("\t")
end

tweetsComma = []

begin
	IO.foreach(ARGV[0]) { |line| tweetsComma.push pipe_to_comma(line) }
rescue 
	puts "Can't read a Pipe File."
else
	if ARGV[1] == nil	# 결과 파일명 정하기
		targetFileName = File.basename(ARGV[0], '.*') + "_c" + File.extname(ARGV[0])
	else
		targetFileName = ARGV[1]
	end
	File.open(targetFileName, "w") {|file| file.write(tweetsComma.join("\n"))}
	puts "Finished Pipe -> Comma, the filename is #{targetFileName}"
end

