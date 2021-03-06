USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'file:///home/chan/Documents/cancer/cancer.csv' AS line 
WITH line LIMIT 50

MERGE (cancer:Cancer { name: 'Cancer' })
MERGE (genes:Genes { name: 'Genes' })
MERGE (gene:Gene {name: UPPER(line.Gene)})
MERGE (tumors:Tumors { name: 'Tumors' })
MERGE (tumor:Tumor {name: UPPER(line.Tumor)})
MERGE (rnaSamples:RNASamples { name: 'RNASamples' })
MERGE (patient:Patients { name: 'Patients' })
MERGE (total:Totalpatients {name: UPPER(line.Totalpatients)})
MERGE (level:Level {name: UPPER(line.Level)})
MERGE (count:Countpatients {name: UPPER(line.Countpatients)})
MERGE (sample:RNASample{name: UPPER(line.RNASample)})
MERGE (samplevalues:sampleValues { name: 'sampleValues' })
MERGE (value:SampleValue{name: UPPER(line.SampleValue)})
MERGE (abundance:Abundance{name: UPPER(line.Abundance)})

MERGE (cancer)-[:Genes]->(genes)
MERGE (genes)-[:GeneType]->(gene)
MERGE (gene)-[:tumors]->(tumors)
MERGE (tumors)-[:types]->(tumor)
MERGE (gene)-[:RNASamples]->(sample)

MERGE (sample) -[:SampleValues]->(samplevalues)
MERGE (samplevalues) -[:SampleValue]->(value)
MERGE (value) -[:Abundance]->(abundance)
MERGE (tumor)-[:TotalPatients]->(total)
MERGE (total)-[:level]->(level)
MERGE (level)-[:Countpatients]->(count)

RETURN line;
