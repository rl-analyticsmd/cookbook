# AMD_SG Cookbook

This cookbook is basically for creating separate security group with inbound and outbound rules.
 


## Attributes

default[:AMD_sg][:pro_type] 
default[:AMD_sg][:sg_name] 
default[:AMD_sg][:vpc_name] 
default[:AMD_sg][:inbound_rules] 
default[:AMD_sg][:outbound_rules]  

## Usage

- change the below attributes 
e.g.
default[:AMD_sg][:pro_type] = 'test'
default[:AMD_sg][:inbound_rules] =  {'0.0.0.0/0' => [ 22, 80 ]}
default[:AMD_sg][:outbound_rules] = {[ 22, 80 ] => '0.0.0.0/0'}

'0.0.0.0/0' is the source.



## License and Authors
Authors: Ashish Raj (ashish.raj@relevancelab.com)