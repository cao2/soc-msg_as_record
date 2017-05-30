from random import randint
import optparse

parser = optparse.OptionParser()

parser.add_option('-n', action='store', dest='tot', help='number of integers to generate', default='1000000')
parser.add_option('-c', action='store', dest='ceil', help='range ceiling', default='9')

parser.add_option('-o', action='store', dest='outf', help='output file', default='rand_ints.txt')

opts, args = parser.parse_args()

with open(opts.outf,"w") as f:
    #f.write(opts.tot + '\n');
    for i in range(int(opts.tot)):
        f.write(str(randint(1,int(opts.ceil))) + '\n')

