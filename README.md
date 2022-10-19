# msw3

This is an incomplete digital archive of original source used to compile:

Don E. Wilson & DeeAnn M. Reeder (editors). 2005. Mammal Species of the World. A Taxonomic and Geographic Reference (3rd ed), Johns Hopkins University Press, 2,142 pp. 

Also, this resources are also packaged as [Preston](https://preston.guoda.bio) archive.

Finally, [msw3.json](msw3.json) is provided to help make the original xls files available in json format.

# Contents

[```data-raw/```](data-raw/)
	Files provided by DeeAnn M. Reeder in Oct 2022.

[```msw3.json```](msw3.json)
	json representation generated using ```preston ls | preston excel-stream > msw3.json```

[```msw3-sample.json```](msw3.json)
	first 10 records from msw3.json generated using ```cat msw3.json | head -n10 | jq . > msw3-sample.json```

[```make.sh```](make.sh)
	script that documents tracking, and conversation of original source files

# JSON 


The original MSW3 data is kept in XLS files. These files use a proprietary file format, and can (at time of writing Oct 2022) still be opened by most spreadsheet programs. However, XLS files are not so easy to work with in platforms like R or programming languages like Python. This is why the data is also offered in other formats like JSON. 

*J*ava*s*cript *O*bject *N*otation (JSON) allows for a hierarchical representation of data. Also, JSON is widely supported in various programming languages, and web browsers "speak" json natively. 

To translate the XLS sources into json, the following assumptions are made:

1. the first row contains the column names
2. column names are used consistently and do not repeat in a single worksheet
3. excel formatting is used to export values
4. formulas and resulting values are ignored

To explain how the transformation was done, please consider the following simplified example.


lets say, an xls file contains a worksheet "VALID NAME DATA" with the following values: 

| ORDER | FAMILY | GENUS | SPECIES |
| --- | --- | --- | --- |
| MONOTREMATA | Tachyglossidae | Tachyglossus | aculeatus |

After tracking and packaging the file as a Preston archive using [```make.sh```](make.sh), a JSON file is generated. The file looks something like this:

```json

{
  "http://www.w3.org/ns/prov#wasDerivedFrom": "line:xls:hash://sha256/7fec83b9202dae1b4ac91d6fd6e1cdf448c7167484a04b31c6f9a7c031496641!/VALID%20NAME%20DATA!/L10",
  "http://purl.org/dc/elements/1.1/format": "application/vnd.ms-excel",
  "ORDER": "MONOTREMATA",
  "FAMILY": "Tachyglossidae",
  "GENUS": "Tachyglossus",
  "SPECIES": "aculeatus"
}
```

Note how the provenance of the data is provided in the key ```http://www.w3.org/ns/prov#wasDerivedFrom```, as well as the type of source file ```application/vnd.ms-excel```. This metadata helps to trace the origin of the values when needed. The other values for keys ```ORDER```, ```FAMILY```, etc. were extracted from the original data.

This process is repeated for all rows, worksheets across the tracked workbooks. The result is included in [msw3.json](msw3.json) and can be transformed into other formats like csv, tsv, etc. if needed. 

For instance, to extract all order values across the data, you can use [jq](https://stedolan.github.io/jq/) to list a frequency table of occurrences of distinct orders:

```
cat msw3.json\
 | jq --raw-output '.["ORDER"]'\
 | sort\
 | uniq -c\
 | sort -nr\
 | head 
```

yields:

```
  13556 
   4728 RODENTIA
   2716 CHIROPTERA
   1706 CARNIVORA
   1008 ARTIODACTYLA
    808 PRIMATES
    766 SORICOMORPHA
    363 LAGOMORPHA
    314 DIPROTODONTIA
    227 AFROSORICIDA
```




# Provenance
# Citation Signature

hash://sha256/ecf01b624bb293c43a715eb71aacb64d385fe225d3e5669c451f23ed753c8eaf

![qrcode](qrcode.png)
