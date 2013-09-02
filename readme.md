# K-Shaper



## UPDATE (2009) !!!
The virtual interface used to handle traffic flow is "IMQ": it is not available anymore in recent kernels, and the new one is "IFB" - I don't have time to update perl script, but I think it is not so difficult: perhaps a few of "string replace", eventually with right arguments.


K-Shaper is tool for traffic-shaping in a Linux router/firewal based network.  

If you know how it is hard to get a working traffic-shaping configuration in Linux, using tc and/or iptables, so you would use k-shaper.  

You can think a traffic flow as a tree, and every sub-flows as branch or final leaf: then, an xml file could be a good way to map this hierarchy.

So, why worry with "tc" syntax? We could write a configuration using xml nodes and attributes, and finally let an xml parser translates the xml tree in tc/iptables rules.

Really, K-shaper just consists of an xsd schema as model for xml configuration instances, and a perl parser for translation step.

Only C class lan is available in this release, while various filters are provided: 
 * _ip_ (single/range)
 * _port_ (tcp/udp)
 * _owner_ (pid/gid/user)  <- work only on box executing shaping rules
 * _layer7_ filter: this is an interesting filter, because it allows to handle traffic at osi 7th layer, that is "ssh", "http", "ftp", "ed2k", apart of used port (you know: 80 is http default port - but if anyone use 2080 for his web server? a simple "port" filter will not work, while layer7 does).

These filters are provided by iptables/netfilter, but not all are available in vanilla kernel (at 2.6.28): you need some kernel patch as "zen" or "liquorix"; in addition, some options for "owner" filter are not available on SMP kernel (read the module info for details)


Nice tips: you can compile an xml configuration using an assisted ide, such as Eclipse or Oxygen, and when you provide the xsd schema included in src, you can have advantage of xml autompletion/suggestion by ide.

Finally, executing "k-shaper" command, obviously giving it written xml configuration, it will generate a bash script containing tc/iptables rules. Just execute it and that's all.


p.s.:
when I wrote this tool (2006), I choiced a parsing by perl because it ran very fast, especially for schematron parsing (xsd schema contains also some schematron rules for better checks), while xsl-t tools does not.
Obviously, now we have better and fast engines, so any willing guy could contribute writing an xsl-t sheet, which permits to get final bash script just using a browser ;D

 
Because its age (7 years), k-shaper could be likely an old story, and perhaps there are better tools for this stuff:
However, it was developed for my academic training, and used for some experiment in my university laboratories, so I choiced to make available all code for same educational and experimental purposes.
