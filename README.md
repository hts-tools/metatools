metatools
Tools for analysis of high throughput sequencing data  

#
Function waps (weighted averages using phyloseq-class objects)  
For every i species, or higher level taxonomy, the observed optimum environmental levels of selected variables are estimated by computing the averages – weighted by the corresponding abundances values – of the variable values in the corresponding samples where the i species were identified. Species optima (uk), and species tolerances (tk), were computed using standard approaches (ter Braak and van Dame, 1989, and Salmaso, 2003).

example: reswaps <- waps(inputps = psobject, varweight = "Oxygen", taxopt = "Genus", ranktax = FALSE)  

- inputps, a phyloseq object  
- varweight, the name of the variable to analyze (e.g. "Oxygen")  
- taxopt, the taxonomic level to be analyzed  
- ranktax, if TRUE the table includes full taxonomic information  

Author, Nico Salmaso, 11 July 2019  

References  
- ter Braak, C. J. F., and van Dame, H. (1989). Inferring pH from diatoms: a comparison of old and new calibration methods. Hydrobiologia 178, 209–223. doi:10.1007/BF00006028.  
- Salmaso, N. (2003). Life strategies, dominance patterns and mechanisms promoting species coexistence in phytoplankton communities along complex environmental gradients. Hydrobiologia, 13–36. doi:10.1023/B:HYDR.0000004267.64870.85.  

Implementation  
Salmaso, N. (2019) Effects of Habitat Partitioning on the Distribution of Bacterioplankton in Deep Lakes. Front. Microbiol. 10:2257. doi: 10.3389/fmicb.2019.02257
#
