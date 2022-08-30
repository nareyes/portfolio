import pandas as pd

# import current data
gongos_current = pd.read_excel("gongos_current.xlsx")

# import new data
gongos_new = pd.read_excel("gongos_new.xlsx")

# promote proper headers
gongos_new.columns = gongos_new.iloc[4]

# remove top rows
gongos_new.drop(axis = 0, index = [0, 1, 2, 3, 4, 5, 6], inplace = True)

# rename columns
gongos_new.rename(inplace = True, columns = {
    'Monthly Attrition': 'Monthly Attrition Base',
    'Rolling 12-Month Attrition': 'Rolling 12-Month Attrition Base'
})

# add new columns
gongos_new.insert(36, 'Monthly Attrition Factor', value = '') # replace blank with value when needed
gongos_new.insert(37, 'Monthly Attrition', value = ' ')
gongos_new.insert(39, 'Rolling 12-Month Attrition Factor', value = '') # replace blanks with value when needed
gongos_new.insert(40, 'Rolling 12-Month Attrition', value = ' ')
gongos_new.insert(66, 'Date', value = '06/01/2022') # replace with new date

# perform transformations on attrition columns where existing values are all 0
gongos_new.iloc[:, 35].replace(to_replace = 0, value = '', inplace = True)
gongos_new.iloc[:, 38].replace(to_replace = 0, value = '', inplace = True)

# perform transformations on attrition columns where existing values are not 0
# gongos_new.iloc[:, 36].replace(to_replace = '', value = 1, inplace = True)
# gongos_new.iloc[:, 39].replace(to_replace = '', value = 1, inplace = True)
# gongos_new['Monthly Attrition'] = gongos_new['Monthly Attrition Base'] * gongos_new['Monthly Attrition Factor']
# gongos_new['Rolling 12-Month Attrition'] = gongos_new['Rolling 12-Month Attrition Base'] * gongos_new['Rolling 12-Month Attrition Factor']

# concat new and existing data
frames = [gongos_current, gongos_new]
gongos_final = pd.concat(frames)

# save final data frame
gongos_final.to_excel('gongos_final.xlsx', index = False)