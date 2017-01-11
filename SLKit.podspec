Pod::Spec.new do |s|
	s.name			= 'SLKit'
	s.version		= '0.1.0'
	s.platform		= :ios, '10.0'
	s.summary		= 'SLKit'
	s.homepage		= 'http://iqiqi.space'
	s.authors		= { 'SL' => 'sl@52772577.com' }
	s.source		= {:git => 'git@github.com:sl-sl-sl-sl-sl/SLKit.git'}
	s.license		= 'GPL'

	s.pod_target_xcconfig = {
		'SWIFT_VERSION' => '3.0',
	}

	s.requires_arc	= 'true'
	s.source_files	= '*.swift'
end
	      