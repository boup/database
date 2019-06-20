
/* Procedure */
Create Procedure Stocker
as
declare @i int,@j int;
set @i=1;
set @j=1;
while(@i>0)
BEGIN
     Insert into  sas_vendeur(matricule,nom)
     Select Distinct matricule,nom from src_vendeur
     where Not Exists(select * from src_vendeur
                      where src_vendeur.matricule=sas_matricule.matricule)
     set @i=@@ROWCOUNT
set @j+=1;
END    

/* */
where null=null --ne verifie rien
il est conseillle de ecrire isNull soit:
Insert into  sas_vendeur(matricule,nom)
     Select Distinct matricule,nom from src_vendeur
     where Not Exists(select * from src_vendeur
                      where isnull(src_vendeur.matricule,'oooo')=(sas_matricule.matricule,'oooo'))
                      
                      
 /*  Reception d'une valeur null  */
 Insert into  sas_vendeur(matricule,nom)
     Select Distinct  Isnull(matricule,'Inconnue'),nom 
     from src_vendeur
     where Not Exists(select * from src_vendeur
                      where src_vendeur.matricule=sas_matricule.matricule)
                      
					  
					--  SAS --
 /*  matricule    nom        Mnt   Qtité
       A105      vendeur1   5000     2 
       Null             2    10000   1
       Null             3    25000   4
       Null             4     3000   3    
 on aura     
   idvendeur    Mnt   Qtité
      2         5000     2
      1        10000     1
      1        25000     4
      1         3000     3  */   
  
 /* Rejets Fonctionnels (21/07/2014)
  matricule    nom        Mnt   Qtité
       A105      vendeur1   5000     2 
       Null             2    10000   1
       Null             3    25000   4
       Null             4     3000   3     
       
   sas (21/07/2014)
  matricule    nom        Mnt   Qtité
       A105       valeur1   5000     2 
       Null             2    10000   1
       Null             3    25000   4
       Null             4     3000   3    */     
       
 /* Si un vendeur change de ville */
    Update Vendeur
    set ville=sas_ventes_jour.ville
    where vendeur.matricule=sas.matricule    
          