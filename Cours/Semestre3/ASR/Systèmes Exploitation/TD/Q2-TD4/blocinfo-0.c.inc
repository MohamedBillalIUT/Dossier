void blocinfo(void* ptr)
{
 bloc_entete* bloc_total= (bloc_entete*) ((char*)ptr - ENTETE_SIZE);
 printf("pointeur bloc %p \n, pointeur donnees %p \n, taille totale: %d, \nbloc libre ?: %d\n",
	bloc_total,
	ptr,
	bloc_total->taille,
	bloc_total->libre);
}
