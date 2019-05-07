/*******************************************************************

To compile, use
cc -o minfo minfo5.c -lm

To run, use
./minfo datafile -b 100 -t 100 > r.mi

# Reference
# http://www.physics.emory.edu/faculty/weeks//software/minfo.html


minfo.c -- Eric R. Weeks -- started 2/28/97

does the mutual information algorithm discussed by Fraser & Swinney
(Phys Rev A 33 (1986) p1134-1140)

v01:  2-28-97: taken from shell.c (7/1/96)
			quicksort routine taken from sane.c (original version)
v02:  2-28-97: revised sorting for s[] (different than q[])
			sped up math
v03:  2-28-97: add in tau loop
	 3-01-97: fix for variable number of input; add -b option
v04:  3-01-97: take out chi2 tests for substructure
v05:  3-01-97: realize that with chi2 tests taken out, number()
			function doesn't need to be called very often.  remove
			a[] and b[][] arrays!  Much faster now.

This program is public domain, although please leave my name and
email address attached.

email: weeks@physics.emory.edu
web: http://www.physics.emory.edu/~weeks/

explanation of how to use this program:
    http://www.physics.emory.edu/~weeks/software/minfo.html

 *******************************************************************/
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#define PI 3.14159265358979323846264338328
#define EE 2.71828182845904523536
#define MAXNUM 100000
#define KMAX 25

int s[MAXNUM],q[MAXNUM];
int numpts,n0,mmax;
float pop[MAXNUM];
int pindex[MAXNUM];
int pow2[KMAX];
int bin;
int globalivalue[4];
float logtwo;

int number(int karray2[],int m2);
float findisq();
float ffunct(int kmarray[],int m);
void saneqsort(int p,int r);
int qpartition_neurons(int p,int r);

main(argc,argv)
int argc;
char **argv;
{
	int c;
	double x,y;
	FILE *fp;
	extern int optind;
	extern char *optarg;
	float array[MAXNUM];
	int taumax,i,j,tau;
	float info;

	bin = -1;
	taumax = 20;
	while ((c = getopt(argc, argv, "ht:b:")) != EOF)
	switch (c)  {
case 'h': 
fprintf(stderr,"Usage: %s [options] [<] [file]\n\n",argv[0]);
fprintf(stderr," -h   : this help message\n");
fprintf(stderr," -t # : set taumax, max tau to find mut. info [%d]\n",taumax);
fprintf(stderr," -b # : bin data into 2^# bins [default: all possible]\n");
			exit(1);
			break;
	case 't': taumax = atoi(optarg);
			break;
	case 'b': bin = atoi(optarg);
			break;
        }

	argc -= (optind-1) ; argv += (optind-1) ;
	fp = (argc > 1) ? fopen(*++argv, "r") : stdin;

	numpts = 0;
	while ((fscanf(fp,"%lf",&x)) == 1)  {
		array[numpts] = x;
		++numpts;
	}	/*----- done reading in data -----*/

	logtwo = 1.0/log(2.0);
	n0=1;
	while ((n0+taumax)<=numpts)  n0 *= 2;
	n0 /= 2;

	/* n0 = numpts - taumax; */
	j = n0;
	for (i=0;i<KMAX;i++)  {
		pow2[i] = j;
		j /= 2;
	}
	mmax = ((int)(log(((float)n0))*logtwo+0.1));
	fprintf(stderr,"n0: %d mmax: %d\n",n0,mmax);


	for (i=0;i<n0;i++)  {
		pop[i] = array[i];
		pindex[i] = i;
	}
	saneqsort(0,n0-1);
	/* for (i=0;i<numpts-taumax;i++)  s[pindex[i]] = i; */
	/* WARNING!!!!!! Note that this definition is somewhat opposite
	 * of what 'makes sense' but will make number() routine faster */
	for (i=0;i<n0;i++)  s[i] = pindex[i]; 

	for (tau=0;tau<=taumax;tau++)  {
		/* now do tau offset for q[] array */
		for (i=tau;i<tau+n0;i++)  {
			pop[i-tau] = array[i];
			pindex[i-tau] = i-tau;
		}
		saneqsort(0,n0-1);
		for (i=0;i<n0;i++)  q[pindex[i]] = i;
		/* for (i=0;i<n0;i++)  fprintf(stderr,"%d ",q[i]); */
		/* fprintf(stderr,"\n"); */


		/* assume at this time that s[], q[] contain integers from
		 * 0 to 2^N-1.   q[] is based on the time lagged data from
		 * array[].  s[] is just array[].
		 *
		 * example: s[] = 0 4 5 3 6 1 2 7
		 *          q[] = 7 4 5 3 6 2 0 1
		 *
		 *     o.......      so the first partition is s: 0-3 | 4-7
		 *     ......o.                                q: 0-3 | 4-7
		 *     .....o..
		 *     ....o...      with 3 in LL, 1 in UL, 3 in UR, 1 in LR
		 *     ...o....      quadrants.
		 *     .o......
		 *     .......o      second partition is s: 01 | 23 | 45 | 67
		 *     ..o.....                          q: 01 | 23 | 45 | 67
		 *                   with distribution: 1001
		 *				                    0020
		 *								1100
		 *								0101
		 */

		/* now find I(S,Q) according to formula (19) */
		info=findisq();
		printf("%d %f\n",tau,info);
		fprintf(stderr,"%d %f\n",tau,info);
	}

	exit(0);
}	/* END OF MAIN */



float findisq()
{
	float info;
	int kmarray[KMAX];
	float x,y;

	kmarray[0] = 0;
	x = ((float)n0);
	y = ffunct(kmarray,0);
	info = (1.0/x)*y - log(x)*logtwo;

	return info;
}

float ffunct(int kmarray[],int m)
{
	/* THIS FUNCTION CAN CALL ITSELF RECURSIVELY */
	float value;
	int n,j;
	int temparray[KMAX];

	for (j=0;j<=m;j++)  temparray[j] = kmarray[j];

	n = number(temparray,m);
	
	value = ((float)n);
	if (n<=1)  {
		value = 0.0;
	} else if (n==2)  {
		value = 4.0;
	} else if (m==bin)  {
		/* no substructure */
		value = value*log(value)*logtwo;
	} else {
		/* assume substructure exists */
		value = value*2.0;
		for (j=0;j<=3;j++)  {
			temparray[m+1] = j;
			value += ffunct(temparray,m+1);
		}
	}

	return value;
}


int number(int karray2[],int m2)
{
	/* THIS FUNCTION IS NOT RECURSIVE */
	int ivalue;
	int los,his,loq,hiq;
	register int i,j;

	if (m2>0)  {
		los = 0;loq = 0;
		his = n0; hiq = n0;
		for (i=1;i<=m2;i++)  {
			if (karray2[i]%2==0)  his -= pow2[i];
			else                  los += pow2[i];
			if (karray2[i]<2)     hiq -= pow2[i];
			else                  loq += pow2[i];
		}
		ivalue = 0;
		for (i=los;i<his;i++)  {
			j = q[s[i]];
			if ((j>=loq)&&(j<hiq))  ivalue++;
		}
	} else {
		ivalue = n0;
	}

	return ivalue;
}



/* quicksort, taken from sane.c by David E. Moriarty */
/* modified for this purpose */

void saneqsort(p,r)
  int p,r;
{
  int q;
  if (p<r) {
    q = qpartition_neurons(p,r);
    saneqsort(p,q);
    saneqsort(q+1,r);
  }
}

/** partition function for saneqsort.
     **/

int qpartition_neurons(p,r)
  int p,r;
{
  register int i,j;
  float x,temp;
  int tempi;

  x = pop[p];
  i = p - 1;
  j = r + 1;
  while(1) {
    do{
      --j;
    }while(pop[j] < x);
    do{
      ++i;
    }while(pop[i] > x);
    if (i < j) {
	 /* here's where the in-place swap takes place */
	 /* fortunately pindex[] stores the *original* location */
      temp = pop[i]; pop[i] = pop[j]; pop[j] = temp;
	 tempi = pindex[i]; pindex[i] = pindex[j]; pindex[j] = tempi;
    }
    else
      return j;
  }
}

