Pod::Spec.new do |s|
	s.name			= 'SLKit'
	s.version		= '0.1.0'
	s.platform		= :ios, '10.0'
	s.summary    	= 'SLKit'
	s.homepage		= 'http://www.iqiqi.space'
	s.author		= 'sl2577'
	s.source 		= {:git => 'github.com/sl-sl-sl-sl-sl/SLKit.git' } 
	s.license		= 'GPL'
	s.requires_arc 		= true

	s.subspec 'SLTimingManager' do |t| 
	    t.source_files = '**/*.swift'
    	t.requires_arc = true
	end
end
