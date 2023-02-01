# -----------------  improting packages -----------------
import sys 
import matplotlib.pyplot as plt
import numpy as np

# ----------------- Loading the file -----------------
with open(sys.argv[1]) as f:
    content = f.read().splitlines()


# ----------------- Parsing Data -----------------
start_l=[]
end_l  =[]
for i,j in enumerate(content):
    if 'Per MPI rank memory allocation' in j:
        start_l.append(i+2)
#    if 'Loop time of' in j:
    if 'Loop time of' in j or 'colvars: Saving collective variables' in j:
        end_l.append(i-(start_l[-1]))


if len(start_l) != len(end_l):
    print('Your simulation has not finished properly!')
    
if len(start_l) > 1:
    print('You have more than 1 simulation. Please specify the desired section in the code.')

# To do, Asking the section from user.

counter = 0
for i in zip(start_l,end_l):
    print(counter, ':(Start-MaxRow):\t',i)
    counter +=1
    
# desired section
section = 1

Data = np.loadtxt(fname=sys.argv[1] ,skiprows=start_l[section], max_rows=end_l[section])
print('\nReading...! \nMatrix size:\t', Data.shape)



# ----------------- Defing quantities -----------------
time = Data[:,1:2]/1000000
temp = Data[:,2:3]
press= Data[:,3:4]
vol  = Data[:,4:5]
toteng=Data[:,5:6]
dens = Data[:,19:20]



xdim = Data[:,16:17]
ydim = Data[:,17:18]
zdim = Data[:,18:19]
N_links = Data[:,21:22]

# ----------------- matplotlib -----------------

fig, ax = plt.subplots(nrows=3,ncols=2, figsize=(20,10))
fig.canvas.manager.set_window_title('Thermodynamics')


ax[0,0].plot(time,temp, label='Temprature')
ax[0,0].axhline(y=np.average(temp), color='r')
ax[0,0].text(0.4, 0.8,size=12, color='w', transform=ax[0,0].transAxes, backgroundcolor='tab:orange', \
             s='average={}\nstd={}'.format(np.round(np.average(temp), decimals=3), np.round(np.std(temp), decimals=3)))
ax[0,0].set_xlabel('Time (ns)')
ax[0,0].set_ylabel('Temprature (K)')
ax[0,0].legend()


ax[0,1].plot(time,press, label='pressure')
ax[0,1].axhline(y=np.average(press), color='r')
ax[0,1].text(0.4, 0.1,size=12, color='w', transform=ax[0,1].transAxes, backgroundcolor='tab:orange', \
             s='average={}\nstd={}'.format(np.round(np.average(press), decimals=3), np.round(np.std(press), decimals=3)))        
ax[0,1].set_xlabel('Time (ns)')
ax[0,1].set_ylabel('pressure (atm)')     
ax[0,1].legend()


ax[1,0].plot(time, vol, label='volume')
ax[1,0].axhline(y=np.average(vol), color='r')
ax[1,0].text(0.4, 0.8,size=12,color='w',transform=ax[1,0].transAxes,backgroundcolor='tab:orange' ,\
             s='average={}\nstd={}'.format(np.round(np.average(vol), decimals=3), np.round(np.std(vol), decimals=3)))
ax[1,0].set_xlabel('Time (ns)')
ax[1,0].set_ylabel('volume (A^3)') 
ax[1,0].legend()

ax[1,1].plot(time,toteng, label='Total Energy')
ax[1,1].axhline(y=np.average(toteng), color='r')
ax[1,1].text(0.4, 0.8,size=12, color='w', transform=ax[1,1].transAxes,backgroundcolor='tab:orange', \
             s='average={}\nstd={}'.format(np.round(np.average(toteng), decimals=3), np.round(np.std(toteng), decimals=3)))
ax[1,1].set_xlabel('Time (ns)')
ax[1,1].set_ylabel('Total Energy (Kcal/mol)') 
ax[1,1].legend()


ax[2,0].plot(time,N_links, label='Number of links')
ax[2,0].set_xlabel('Time (ns)')
ax[2,0].set_ylabel('N links') 
ax[2,0].legend()


# ----------------- matplotlib -----------------

fig, ax = plt.subplots(nrows=3,ncols=1, figsize=(20,10))
fig.canvas.manager.set_window_title('Size of the Box')

ax[0].plot(time, xdim, label='X Dimension')
ax[0].set_xlabel('Time (ns)')
ax[0].set_ylabel('Size of the Box (A)')
ax[0].legend()

ax[1].plot(time, ydim, label='Y Dimension')
ax[1].set_xlabel('Time (ns)')
ax[1].set_ylabel('Size of the Box (A)')
ax[1].legend()


ax[2].plot(time,zdim, label='Z Dimension')
ax[2].set_xlabel('Time (ns)')
ax[2].set_ylabel('Size of the Box (A)')
ax[2].legend()

plt.show()

