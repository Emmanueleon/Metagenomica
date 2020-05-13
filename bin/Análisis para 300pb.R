### Para 300pb

library(phyloseq)
library(vegan)
library(ggplot2)
library(ggpubr)

sample_300 <- import_biom("../data/taxonomy300.biom")
sample_300
outdir     <- "../output/Taxonomy_300/"


head(otu_table(sample_300))  
head(tax_table(sample_300))
head(sample_data(sample_300))

colnames(tax_table(sample_300)) <- c("Domain", "Phylum", "Class", "Order", "Family", "Genus", "Species")

no.read=sort(sample_sums(sample_300))
no.read 


###Estimación de la diversid alfa 
### A nivel de Filo y de acuerdo al tratamiento
Phylum_treatment <- plot_bar(sample_300, "Treatment", fill = "Phylum") + 
  geom_bar(aes(color=Phylum, fill=Phylum), stat="identity", position="stack")
Phylum_treatment

Phylum_host <- plot_bar(sample_300, "Host", fill = "Phylum") + 
  geom_bar(aes(color=Phylum, fill=Phylum), stat="identity", position="stack")
Phylum_host

Figura_Filos <- Phylum_treatment + facet_wrap("Host")
ggsave(path = outdir, "Figura_filos300.png", width = 5, height = 5)

###Ausencia 
sample_300_decostand <- decostand(otu_table(sample_300), method="pa")
head(sample_300_decostand)


###Para observar la diversidad se utilizaran dos métricas, La observada y la de Fisher
###Presencia Ausencia
diversity_decostand<- estimate_richness(sample_300_decostand, measures =c("Observed", "Fisher"))
diversity_decostand

data <- cbind(sample_data(sample_300), diversity_decostand)
View(data)
diversity_table_300 <- write.table(data, file="../output/Taxonomy_300/diversity_table_300.tsv", 
                                   quote=FALSE, sep ='\t', col.names = NA)

###Anova
###Anova entre Huéspedes
host_treatment_Fisher <- aov(Fisher~Host*Treatment, data = data)
summary(host_treatment_Fisher)

host_treatment_Observed <- aov(Observed~Host*Treatment, data = data)
summary(host_treatment_Observed)

#Entre Huésped 
a <- ggplot(data = data, aes(x=Host, y=Observed, fill=Host))+
  geom_boxplot()
b <- ggplot(data = data, aes(x=Host, y=Fisher, fill=Host))+
  geom_boxplot()

#Entre Tratamiento
c <- ggplot(data = data, aes(x=Treatment, y=Observed, fill=Host))+
  geom_boxplot()

d <- ggplot(data = data, aes(x=Treatment, y=Fisher, fill=Host))+
  geom_boxplot()

Figura.1 <- ggarrange(a, b, c, d, 
                      labels = c("Huésped/Observada", "Huésped/Fisher", "Tratamiento/Observada", "Tratamiento/Fisher"), 
                      ncol=2, nrow = 2)

ggsave(path = outdir, "Figura_diversidad.png", width = 5, height = 5)
### Beta Diversidad
### Para poder realizar el análisis de la B diversidad se debe de hacer ordinaciones
euclidean <- distance(sample_300_decostand, method="euclidean")  #Con el comando distance se observan otras maneras de distancia"
euclidean

# Se puede hacer ordinación basada en tabla de disimilitud con NMDS
NMDS=ordinate(sample_300_decostand, method = "NMDS", distance=euclidean)
NMDS
sample_300_decostand

###No se observa diferencia significativa por los datos que se tienen
e<- plot_ordination(sample_300, NMDS, color="Host", shape = "Treatment")+
  geom_point(size=2)+
  facet_wrap(~Treatment)+
  theme_bw()

f <- plot_ordination(sample_300, NMDS, color="Host", shape = "Treatment")+
  geom_point(size=2)+
  facet_wrap(~Host)+
  theme_bw()

figure <- ggarrange(e, f, 
                    labels=c("Tratamiento", "Huésped"), 
                    ncol=1, nrow = 2)
figure

ggsave(path = outdir, "Distancia_euclidiana.png", width = 5, height = 5)
