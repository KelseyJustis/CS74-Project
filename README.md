# READ ME 

COURSE MEDIAN PREDICTION VIA SYLLABI ANALYSIS

Authors: Graeson McMahon, Kelsey Justis, Coralie Phanord

	- TO RUN ALGORITHM:

		In AlgCodeFinal, execute 'runHandpicked.m' (specifying number of random partitions (reps) and maximum depth (depth))
	        to run the version that includes only our handpicked feature set. Execute 'runDictionary.m' with the same parameters to
		run the version that includes every word found as a feature (this process is VERY long for even modest depths, due to the size
		of the feature set. 



	- Folder breakdown:

		-AlgCodeFinal: Final version of decision tree algorithm

		-OldAlgorithmVersions: Version of algorithm from early tests and milestone
		
		-OutsideVocabDatabases: .txt files used by the parser to extract certain features (for instance, a list
					of 'testing' words)

		-ParserCode: Code to extract features from syllabi .txt files

		-PDFTextExtractionCode: Reads in our .csv file of medians; given a syllabus .txt file, pairs it with the corect median. 
					Also contains .txt files for every syllabus.



