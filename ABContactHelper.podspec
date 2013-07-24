Pod::Spec.new do |s|
  s.name     = 'ABContactHelper'
  s.version  = '0.0.1'
  s.license  = 'BSD'
  s.summary  = 'Objective-C Address Book wrapper.'
  s.homepage = 'https://github.com/erica/ABContactHelper'
  s.author   = { 'Erica Sadun' => '' }
  s.source   = { :git => 'https://github.com/mattbocosoft/ABContactHelper.git' }
  s.platform = :ios
  s.source_files = 'ABContact.{h,m}', 'ABGroup.{h,m}', 'ABContactsHelper.{h,m}'
  s.frameworks = 'AddressBook', 'AddressBookUI'
end
