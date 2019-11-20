#Load packages
library(tidyverse)
library(gapminder)
library(nycflights13)
library(Lahman)
# ============================================================================================================
# Chapter 1: Data Visualisation with ggplot -------------------------------
# ============================================================================================================

#Visualising the mpg dataframe and its assoicated relationships
ggplot2::mpg

#To plot mpg, run the code below to put displ on the x-axis and hwy on the y-axis:
#Hypothesis: does  a car with a large displacement have lower fuel efficiency than a 
#car with a smaller displacement?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
#The plot shows a negative relationship between engine size (displ) and fuel efficiency (hwy).  Therefore,
#this confirms the hypothesis stated above.

#The function ggplot() creates a cartesian coordinate system that you can add layers to. The first argument 
#is the data set that you are referring to. The function geom_point() adds a layer of points to your plot, which
#creates a scatter plot.  ggplot() comes with many geom functions that each add a different type of layer to
#a plot.

#Each geom function in ggplot() takes a mapping argument.  This argument defines how variables in your data set
#are mapped to visually properties.  The mapping() argument is always paired with aes(), and the x and y 
#arguments of aes() specify which variables to map to the x and y axes.

#===========A Graphing Template=============
#ggplot(data = <DATA>) +
#  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

#1. Run ggplot(data = mpg).  What do you see?
ggplot(data = mpg)
#Ans: nothing as you have not layered the geometric function
#2. How many rows are in mtcars? How many columns?
#10 and 1
#3. What does the drv variable describe? Read the help for ?mpg
#   to find out.
#The drv variable describes the drive train type of the vehicle; i.e. whether front wheel drive,
#rear wheel, or 4 wheel drive.
#4. Make a scatterplot of hwy versus cyl
ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cyl))
#5. What happens if you make a scatterplot of class versus drv? Why is the plot not useful?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))
#Because it is a categorical variable.

#=============Aesthetic Mappings=============
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
#You'll notice in the above plot that there are several outliers on the far right x-axis and middle y-axis.
#Let's hypothesis that the cars are hybrid cars.  We can test this hypothesis by looking at the class value
#for each car.  If the cars are hybrids they should be classified as compact cars.

#You can add a third variable, like class, to a two-dimensional scatterplot by mapping it to an aesthetic.
#An aesthetic is a visual property of the objects in your plot.  Aesthetics inlcude things liek size, 
#shape, or the colour of your points.  For example, let's display the points in colours according to class.
#Hence, aesthetic properties have various 'levels'.  We can change the levels of a point's size, shape and
#colour to make the point small, triangular, or blue for instance.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, colour = class))
#Therefore, to associate an aesthetic to a variable, associate the name of the aesthetic to the na,me of the
#variable inside aes().

#The colours reveal that many of the outlying cars are two-seater cars.  These are, in fact, sports cars.
#Sports cars have large engines like SUV's and trucks, but small bodies which improves the gas mileage.

#We could also map the size aesthetic to class.  However, you will notice a warning; mapping an unordered
#variable to an ordered aesthetic is not advised.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
#Warning message:
#Using size for a discrete variable is not advised. 

#We ciuld also map class to the alpha aesthetic; alpha controls the transparency of the points, also or we
#could map class to the shape of the points.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
#or
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
#However, with mapping shape to class, ggplot will only use six shapes at a time.  By default, additional
#groups woill go unplotted.

#You can also set the aesthetic properties of your geom manually.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), colour = "blue")
#Here the  colour doesnt convey info about the variable, but only changes the appearance of the plot.  To set
#an aesthetic manually, set the aesthetic name as an argument of your geom function, i.e. it goes outside
#of aes().

#1.Map a continious variable to colour, shape, and size.  What happens?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = displ, shape = displ, colour = displ))
#A continious variable cannot be mapped to shape...
ggplot(mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = displ, colour = displ))

#2. When you map mutliple aesthetics to the same variable, this 'layers' the aesthetic levels.  However,
#be wary of overplotting a variable.

#3. What does the stroke aesthetic do?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, stroke = displ))
#stroke changes the width of the border of the shape of the data point.

#4. What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ < 5)?
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy, colour = displ < 5))
#The above argument groups points into logicals.  I.e. true or false.

#===================Common Problems====================
#For eyeballing code bugs, check the left hand side of the console.
#If there is a +, it means R doesn't think you've typed a complete
#expression and it's waiting for you to finish.  

#One common problem with ggplot is putting the + and the start
#of a line instead of at end.

#=====================Facets===========================
#Another way to add additional variables, besides aesthetics, is using facets.  This is particularly
#useful for categorical variables, like gender.  Facets create subplots that each display one subset
#of your data

#To facet your plot by a single variable, use facet_wrap().  The first argument of facet_wrap() should be
#a formula, which you create with ~ followed by a variable name.  The variable name that you pass to
#facet_wrap() should be discrete:
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 8)
#To facet your plot on the combinsation of two variables, add facet_grid() to your plot call.  The first
#argument of facet_grid() is also a formula.  This time the formula should contain two variable names
#seperated by a ~:
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)
#If you prefer not to facet in the rows or columns dimesion, use a . instead of a variable name.
#For example,  facet_grid(. ~ cyl)
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

#=================================Geometric Objects=================================
#Different geometrical objects (or geoms) are able to visually represent the same data
#in different ways.  For example, bar graphs use bar geoms, line charts use line geoms
#boxplots use box geoms.  Scatterplots break this trend; they use point geoms.
#Therefore, you use different geoms to plot the same data, see below:
#Using geom_point
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy))
#using geom_smooth
ggplot(mpg) +
  geom_smooth(aes(x = displ, y =hwy))

#Every geom function in ggplot2 takes a mapping argument.  However, not every aesthetic argument works with
#every geom.  For example, you can set the shape of a point, but you cant set the shape of a line.  However, 
#you could set the linetype of a line.  geom_smooth() will draw a different line, with a different linetype,
#for each unique value of the variable that you map to linetype:
ggplot(mpg) +
  geom_smooth(aes(x = displ, y = hwy, linetype = drv))
#Here geom_smooth() seperates the cars into three lines based on their drv value, which describes a car's
#drivetrain.  We can add to the aesthetic layering by colouring according to drv.
ggplot(mpg) +
  geom_smooth(aes(x = displ, y = hwy, linetype = drv, colour = drv))


#ggplot automatically groups variables however, for categorical variables it can be a valuable input.
ggplot(mpg) +
  geom_smooth(aes(x = displ, y = hwy, linetype = drv, colour = drv, group = drv))
#furthermore, one can hide the legend:
ggplot(mpg) +
  geom_smooth(aes(x = displ, y = hwy, linetype = drv, colour = drv), show.legend = FALSE)

#To display multiple geoms in the same plot, add multiple geom functions to ggplot():
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  geom_smooth(aes(x = displ, y = hwy))
#This however, introduces some duplication into our code.  For instance, changing the y-axis value 
#of hwy would require you to change it twice.  You can avoid this repitition by passing a set of
#mappings to ggplot().  ggplot() will treat these mappings as global mappings to each geom in the 
#graph.  Below produces the same graph as above:
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()
#If you place mappings in a geom function, ggplot will treat them as local mappings for the 
#specified layer.  It will overwrite the gobal mappings for that layer only:
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = class)) +
  geom_smooth()
#You can use the same idea to specify different data for each layer.  For example, you can use the 
#smooth line to display a subset of the mpg dataset, the subcompact cars.  The local argument overrides
#the global argument:
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = class)) +
  geom_smooth(
    data = filter(mpg, class == "compact"),
    se = FALSE
  )
#plot practice:
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(aes(group = drv), colour = "blue",
              show.legend = FALSE,
              se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(aes(colour = drv), 
              se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(aes(linetype = drv, colour = drv), 
              se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(
    data = filter(mpg, drv == "4"),
    se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv))

# ============================================================================================================
#======================Statistical Transformations=====================
# ============================================================================================================
#Although bar charts seem overly simple, let's explore the use of a bar chart to reveal something subtle about
#plots.  
ggplot(diamonds) +
  geom_bar(aes(x = cut))
#As you can see, plots like bar charts, histograms, and frequency polygons bin your data and then
#plot bin counts, the number of points that fall in each bin.
#Smoothers fit a model to your data and then plot predictions from the model.
#Boxplots compute a robust summary of the distribution and display a specially formatted box.

#The algorithm used to calculate new values for a graph is called a stat, short for statistical transformation.
#You can learn which stat a geom uses by inspecting the default value for the stat argument.  The default
#value for stat is count.  Therefore, geom_bar() uses stat_count().  

#You can generally use geoms and stats interchangeably .  
ggplot(diamonds) +
  stat_count(aes(x = cut))
#This works because every geom has a default stat and every stat has a default geom.  However, there are
#reasons why you might need to use stat explicitly:

#1. You might want to override the default stat.  The following is an example of changing the stat of
#   geom_bar() from the count (the default) to identity.  This lets you map the height of the bars to
#   the raw value of the y variable.  
demo <- tribble(
  ~a, ~b,
  "bar_1", 20,
  "bar_2", 30,
  "bar_3", 40
)

ggplot(demo) +
  geom_bar(
    aes(x = a, y = b), stat = "identity"
  )

#2. You might want to override the default mapping from transformed variables to aesthetics.  For example,
#   you might want to display a bar chart of proportion, rather than count:
ggplot(diamonds) +
  geom_bar(
    aes(x = cut, y = ..prop.., group = 1)
  )

#3. You might want to draw greater attention to the statistical transformation in your code.  For example,
#   you might use stat_summary(), which summarises the y values for each unique x value, to draw attention
#to the summary that you're computing:
ggplot(diamonds) +
  stat_summary(
    aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )
#How could you rewrite the above plot using the default geom associated with stat_sum?
ggplot(diamonds, aes(x = cut, y = depth)) +
  geom_pointrange(
    aes(x = cut, 
        ymin = 40,  
        ymax = 80))

#====================Position adjustments==================
#You can either colour a bar chart using either the colour aesthetic, or more usefully,
#fill:
ggplot(diamonds) +
  geom_bar(aes(x = cut, colour = cut))
#or
ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = cut))
#fill fills the entire bar; colour highlights the bars outline.

#Note: what happens if you map the fill aesthetic to another variable, like clarity?
ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = clarity))
#The bars are automatically stacked.  Each coloured rectangle represents a combination of cut and clarity.
#This type of stacking is performed automatically by the position adjustment specificed by the position
#argument.  If you dont want a stacked chart, you can use one of the three other options: "identity",
#"dodge" or "fill"

#   position = "identity" will place each object exactly where it falls in the context of the graph.  This
#   is not very useful for bars because it overlaps them.  To see that overlapping we either need to make
#   the bars slightly transparent, by setting alpha to a small value, or completely transparent by setting
#   fill = NA.
#E.g. 1
ggplot(diamonds, aes(x = cut, 
                     fill = clarity)) +
  geom_bar(alpha = 1/5, 
           position = "identity")
#E.g. 2
ggplot(diamonds, aes(x = cut, 
                     colour = clarity)) +
  geom_bar(fill = NA, position = "identity")
#The "identity" position adjustment is more useful for 2D geoms, like points, where it is the default.

#   position = "fill" works like stacking, but makes each set of stacked bars the same height.  This makes
#   it easier to compare proportions across groups.  For example:
ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = clarity),
           position = "fill")
#   position = "dodge" places overlapping objects directly beside one another.  This makes it easier
#   to compare individual values:
ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = clarity), 
           position = "dodge")

#There's another type of position adjustment, but it is only useful for scatterplots.  Recall the first
#plot.  The values of hwy and displ were rounded so the points appeared on a grid and many overlapped.
#This problem is known as overplotting.  You can avoid this griddling by setting the position adjustment
#to "jitter".

#   position = "jitter" adds a small amount of random noise to each point.  This spreads the points out
#because no two points are likely to recieve the same amount of random noise:
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy), 
             position = "jitter")
#While "jitter" makes your graph less accurate at small scales, it makes your graph more revealing at
#large scales.  Because this is so useful, ggplot comes with a shorthand for geom_point(position = "jitter"):
ggplot(mpg) +
  geom_jitter(aes(x = displ, y = hwy))


#======================Coordinate Systems===================
#The default coordinate system is the Cartesian coordinate system where the x and y position act
#independently to find the location of each point.  However, other types of coordinant systems can 
#be helpful:

#   coord_flip() switches the x and y axes.  This is useful (for example) if you want horizontal boxplots.
#   It's also very useful for long-labels - it's hard to get them to fit without overlapping on the x-axis:
ggplot(mpg, aes(x = class, y = hwy)) +
  geom_boxplot()
#vs
ggplot(mpg, aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()

#   coord_quickname() sets the aspect ratio correctly for maps.  This is very important if you're plotting
#   spatial data with ggplot:
nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")
#vs:
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

#   coord_polar() uses polar coordinates.  Polar coordinates reveal an interesting connection between a bar
#   chart and a Coxcomb chart:
bar <- ggplot(diamonds) +
  geom_bar(
    aes(x = cut, fill = cut),
    show.legend = FALSE,
    width = 1
  ) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

#run different coordinate systems with bar:
bar + coord_flip()
bar + coord_polar()


ggplot(mpg, aes(x= cty, y = hwy)) +
  geom_point() +
  geom_abline() +
  coord_fixed()
#coors_fixed sets a fixed scale coordinate system which forces a specificed ratio between the points on data
#on the axis.

#We can update our plot template:
#ggplot(<DATA>) +
#   <GEOM_FUNCTION>(
#   aes(<MAPPINGS>),
#   stat = <STAT>,
#   position = <POSITION>
#) +
#<COORDINATE_FUNCTION> +
#<FACET_FUNCTION>

# ============================================================================================================
#==========================================Chapter 2:Workflow Basics=========================================
# ============================================================================================================

#When reading coding, say 'object name gets value..."
#e.g. object_name <- value

# ============================================================================================================
#==================================Chapter 3: Data transformation with dplyr=================================
# ============================================================================================================

#Often you'll need to create new variables or summaries, rename or reorder the observations in order to make
#the data easier to work with.
library(nycflights13)
library(tidyverse)
#We will explore the flights data within nycflights13, suing dplyr.
flights
#It only prints the first few columns that fit on the screen because it is a tibble.  Tibbles are data frames
#that are tweaked to work with dplyr.  To view the whole data frame, we state:
View(flights)

#Note: fctr stands for factors, which R uses to represent categorical variables with fixed possible values.

#========dplyr Basics=======
#Pick observations by their values:
(filter())
#Reorder the rows:
(arrange())
#Pick variables by their names:
(select())
#Create new variables with fucntions of existing variables:
(mutate())
#Collapse many values down to a single summary:
(summarise())

#All the above can be used in conjunction with:
(group_by())
#This changes the scope of each funtion from operating on the entire dataset to operating on it group-by-group.
#ALL VERBS WORK SIMILARLY:

#1. The first argument is a data frame
#2. The subsequent arguments describe what to do with the data frame, using the variables names
#(without quotes)
#3. The result is a new data frame

#======Filter rows with filter()
#filter() allows you to sobset observations based on their values.

#The first argument is the name of the data frame.  The second and subsequent arguments are the expressions
#that filter the data frame.
filter(flights, month == 1, day == 1)

#Note: dplyr functions never modify  their inputs, so if you want to save the results, you'll need to 
#create a new object using the assignment operator <-. E.g.
jan1 <- filter(flights, month == 1, day == 1)
jan1

#R either prints out the results, or saves them to an object variable.  If you want to do both, you can 
#wrap the assignment in parentheses:
(dec25 <- filter(flights, month == 12, day == 25))


#=========Comparisons===========
#To use filtering effectively, you have to know how to select the observations that you want using the
#comparison operators.  R privdes the standard suite: >, >=, <, <=, !=, and ==.

#Note:a common problem when using ==: floating numbers
sqrt(2) ^ 2 == 2
1/49 * 49 == 1
#Computers use finite precision arithmetic (they cant store an infinite number of digits), so remember that
#every number you see is an approximation.  Instead of relying on ==, use near():
near(sqrt(2) ^2, 2)
near(1 / 49 * 49, 1)

#======Logical Operators=====
#Multiple arguments to filter() are combined with "and": every expression must be true in order for a row
#to be included in the output.  For other types of combinations, you use Boolean operators: & is "and",
# | is "or", and ! is "not".  For example, the following code finds all flights that departed in November
#or December:
(filter(flights, month == 11 | month == 12))
#It terms of computer logic, this equates to: find all months that evaluate to an expression of TRUE for
#11 or 12 values.
#A useful shorthand for this problem is x %in% y.  This will select every row where x is one of the values
#in y.
(nov_dec <- filter(flights, month %in% c(11, 12)))

#Sometimes you can simplify complicated subsetting by remembering De Morgan's law: 
# !(x & y) is the same as !x | !y, and !(x | y) is the same as !x & !y.  For example, 
#if you wanted to find flights that weren't delayed, by more than two hours, you could use either
#of the following two filters:
filter(flights, !(arr_delay > 120 | dep_delay > 120))
#or
filter(flights, arr_delay <= 120, dep_delay <=120)

#As well as & and |, R also has && and ||.

#Whenever you start using complicated, multipart expressions in filter(), consider making them explicit
#variables instead.  That makes it much easier to check your work.

#=======Missing Values=======
#NA's can make comparisons tricky.  NA's are contagious, so any opertation involving an unknown
#value will also be unknown:
NA > 5
10 == NA
NA + 10
NA / 2
#To determine if a value is missing, use is.na():
x <- NA
is.na(x)

#filter() only includes rows where the condition is TRUE; it excludes the both FALSE and NA values.
#If yoy want to preserve missing values, ask for them explicitly.

df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)

filter(df, is.na(x) | x > 1)
#Find all flights that flew to Houston (IAH or HOU):
View(flights)
(flew_to_Houston <- filter(flights, dest %in% c("IAH", "HOU")))
#Find all flights that were operated by United, American, or Delta:
(operated_by_AA_UA_DL <- filter(flights, carrier %in% c("AA", "UA", "DL")))
#Find all flights that departed in July, August and September:
(flights_dep_summer <- filter(flights, month %in% c(7, 8, 9)))
#Find all flights that arrived more than two hours late, but didnt leave late:
(flights_arrive_late <- filter(flights, arr_delay > 120, dep_time == sched_dep_time))
#Find all flights that were delayed by at least an hour, but made up over 30 minutes in flight:
(flights_delayed_made_up <- filter(flights, dep_delay >= 60, arr_delay <= dep_delay - 30))

#=============Arrange Rows with arrange()=============
#arrange() works similarly to filter(); except it chnages the order of rows.  It takes a set of column names
#(or more complicated expressions) to order by.
arrange(flights, year, month, day)

#Use desc() to reorder by a column in descending order:
arrange(flights, desc(arr_delay))
#Note: missing values are always sorted at the end:
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))

#1. How could you use arrange() to sort all missing values to the start? (Hint: use is.na()):
arrange(flights, desc(is.na(arr_delay)))
#2. Sort flights to find the most delayed flights.  Find the flights that left earliest:
arrange(flights, dep_time, desc(dep_delay))
#3. Sort flights to find the fastest flights:
arrange(flights, air_time)
#4. Which flights travelled the longest? Which flights travelled the shortest?
arrange(flights, desc(distance))
arrange(flights, distance)

#==========Select Columns with select()========
#select() allows you to zoom in on a useful subset using operations based on the names of variables.
# Select columns by name:
select(flights, year, month, day)
# Select all columns between year and day (inclusive):
select(flights, year:day)
# Select all columns except those from year to day (inclusive):
select(flights, -(year:day))
#There are a number of helper functions with select():
# starts_with("abc") matches names that begin with "abc"
# ends_with("xyz") matches names that end with "xyz"
# contains("ijk") matches names that contain "ijk"
# matches("(.)\\1") selects variables that match a regular expression.  This one matches variables that
#contain repeated characters.  
# num_range("x", 1:3) matches x1, x2, and x3.

#rename() is a variant of select() that is useful to rename variables as it keeps all other variables 
#that weren't explicitly mentioned:
rename(flights, tail_num = tailnum)

#You can also use select() in conjunction with everything().  This is useful if you have a handful of
#variables you'd like to move to the start of the data frame:
select(flights, time_hour, air_time, everything())

vars <- c(
  "year", "month", "day", "dep_delay", "arr_delay"
          )
one_of("day", "arr_delay", "year", .vars = vars)
#one_of is useful when you need to match variable names in a character string.  I.e. one can use it to 
#determine which column number the variable is in a large data set.

#The default of select() helpers is to ignore case matching.  If you want to change this, you run:
select(flights, contains("TIME", ignore.case = FALSE))

#===========Add New Variables with mutate()===========
#mutate() will always add new columns at the end of your data set, so beware.
flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time
                    )
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60
      )
#Note: youy can refer to columns that you've just created:
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60,
       hours = air_time / 60,
       gain_per_hour = gain / hours
    )
View(flights_sml)
#If you only want to keep the new variables, use transmute():
transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
        )

#========Useful Creation Functions=========
# Arithmetic Operators: +, -, *, /, ^
#These are all vectorised using the 'recycyling rules'.  If one parameter is shorter than the other, it will
#automatically extended to be the same length.  This is most useful when one of the arguments is a single
#number.

#These are also useful in conjunction with aggregate functions.

# Modular Arithmetic (%/% and %%):
#%/% (integer division) and %% (remainder), where x == y * (x %/% y) + (x %% y).  Modular arithmetic is 
#a handy tool because it allows you to break integers into pieces.  For example, in the flights dataset
#you can compute hour and minute from dep_time:
transmute(flights, 
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100
        )

# Logs: log(), log2(), log10()
#Logarithms are an incredibly useful transformation for dealing with data that ranges across multiple orders
#of magnitude.  They also convert multiplicative relationships to additive.

#All else being equal, it is recommended using log2() because it's easy to interpret: a difference of 1 on
#the log scale corresponds to doubling on the original scale and a difference of -1 corresponds to
#halving.

# Offsets:
#lead() and lag() allow you to refer to leading or lagging values.  This allows you to compute running
#differences (e.g., x - lag(x)) or find when values change (x != lag(x)).  They are most useful in 
#conjunction with groub_by().
(x <- 1:10)
lag(x)
lead(x)

# Cumulative and rolling aggregates:
#R provides functions for running sums, products, mins, and maxes: cumsum(), cumprod(), cummin(), cummax();
#and dplyr provides cummean() for cumulative means.  If you need rolling aggregates, try the RccpRoll package.
x
cumsum(x)
cummean(x)

# Logical comparisons (<, <=, >, >=, !=):
#If you're doing a complex sequences of lofical operations it's often a good idea to store the interim
#values in new variables so you can check that each step is working as expected.

# Ranking
#There are a number of ranking functions, but one should start with min_rank().  It does the most useful
#type of ranking (e.g. first, second, third, fourth).  The default gives the smallest values the smallest
#ranks: use desc(x) to give the largest values the smallest ranks:
y <- c(1, 2, 2, NA, 3, 4)
min_rank(y)
min_rank(desc(y))
#If min_rank() doesn't do what you need, look at the variants row_number(), dense_rank(), percent_rank(),
#cume_dist(), and ntile().
row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)

#===========Grouped Summaries with summarise()==========
#summarise() collapses a data frame to a single row:
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
#summarise() is not terribly useful unless it is paired with group_by().  This changes the unit of analysis
#from the complete dataset to individual groups.  Then, when you use dplyr verbs on a grouped data frame
#they'll be automatically applied 'by group'.  E.g. if we applied exactly the same code to a data frame
#grouped by date, we get the average delay per date:
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))
#Together, group_by() and summarise() provide one of the tools that you'll use most commonly when working
#with dplyr: grouped summaries.

#======Combining Multiple Operations with the Pipe=======
#Say you want to explore the relartionship between the distance and average delay for each location.  Using
#what you know about dplyr, you might write code like this:
by_dest <-  group_by(flights, dest)
delay <- summarise(by_dest,
      count = n(),
      dist = mean(distance, na.rm = TRUE),
      delay = mean(arr_delay, na.rm = TRUE)
    )
delay <- filter(delay, count > 20, dest != "HNL")
View(delay)
#It looks like the delays increase with distance up to ~750 miles 
#and then decrease.  Maybe as flights get longer there's more
#ability to make up delays in the air?
ggplot(delay, aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)
#There are three steps to prepare this data:

#1. Group flights by destination
#2. Summarise to compute distance, average delay,
#   and number of flights.
#3. Filter to remove noisy points and Honolulu
#   airport, which is almost twice ad far away
#   as the next closest airport.

#However, this code is a little frustrating to write because we have to give each intermediate data frame
#a name, even though we don't care about it.  Naming things is hard, so this slows down our analysis.

#There's another way to tackle the same problem with the pipe, %>%:
delays <- flights %>%
  group_by(dest) %>%
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != "HNL")
#A good way to read %>% is 'then'.

#Behind the scenes, x %>% f(y) turns into f(x, y) and x %>% f(y) %>% g(z) turns into g(f(x, y), z), and so on.
#You can use the pipe to rewrite multiple functions in a way that you can read left-tp-right, top-to-botoom.
#Note: look out for updates to ggvis!

# ============================================================================================================
# Missing Values ----------------------------------------------------------
# ============================================================================================================

#All aggregate functions have an na.rm argument.  This removes missing values prior to computation:
flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay, na.rm = TRUE))
#We could also tackle the problem by first removing the cancelled flights.  We'll save the dataset so that
#we can reuse it in the next few examples:
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>%
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

# ============================================================================================================
# Counts ------------------------------------------------------------------
# ============================================================================================================

#Whenever you do any aggregation, it's always a good idea to include either a count (n()), or a count of
#nonmissing values (sum(!is.na(x))).  That way you can check that you're not drawing conclusions based on 
#very small amounts of data.  E.g. look at the planes (identified by their tail num) that have the highest
#average delays:
delays <-  not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay)
  )
delays
ggplot(delays, aes(x = delay)) +
  geom_freqpoly(binwidth = 10)
#Although the graph shows that there are some planes with a delay of more than 5 hours (300 minutes), the 
#story is a little bit more nuanced than that.  We can get mire insight if we draw a scatterplot of number
#of flights versus average delay:
delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )

ggplot(delays, aes(x = n, y = delay)) +
  geom_point(alpha = 1/10)
#This plot is very characteristic: whenever you plot a mean (or other summary) versus group size, you'll see 
#that the variation decreases as the sample size increase.
#Therefore, whenever looking at this sort of plot, it is useful to filter out the groups, with the smallest
#numbers of observations, so you can see more of the pattern and less of the extreme variation in the smallest
#groups.  This is what the following code does:
delays %>% 
  filter(n > 25) %>% 
  ggplot(aes(x = n, y = delay)) +
  geom_point(alpha = 1/10)

#There's another common variation of this type of pattern.  Let's look at how the average performance of
#batters in baseball is related to the number of times they're at bat.  When you plot the skill of the batter
#(ba) against the number of oppurtunities to hit the ball (measured by at bat, ab), you see two patterns:
#1. the variation in our aggregate decreases as we get more data points.
#2. there's a positive correlation between skill (ba) and oppurtunities to hit the ball (ab).  This is
#   because teams control who gets to play, and obviously they'll pick their best players:
Lahman::Batting
#Convert to a tibble so it prints nicely.
batting <- as_tibble(Lahman::Batting)

batters <- batting %>% 
  group_by(playerID) %>% 
  summarise(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
    )

batters %>% 
  filter(ab > 100) %>% 
  ggplot(aes(x = ab, y = ba)) +
  geom_point() +
  geom_smooth(se = FALSE)
#This also has important implications for ranking.  If you naively sort on desc(ba), the people with the
#best batting averages are clearly lucky, not skilled.
batters %>% 
  arrange(desc(ba))

# ============================================================================================================
# Useful Summary Functions ------------------------------------------------
# ============================================================================================================

#Just using mean, count, and sum can get you a long way, but R provides many other useful summary functions:

#Measures of location:
#median(x) is also useful.  

#It's alos useful to sometimes combine aggreagation with logical subsetting:
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    #average delay:
    ave_delay1 = mean(arr_delay),
    #average positive delay:
    ave_delay2 = mean(arr_delay[arr_delay > 0])
  )

#Measures of spread:
#Standard deviation, IQR and median absolute deviation (mad(x)) are robust equivalents that may be more
#useful if they have outliers, e.g.:

#Why is distance to some destinations more variable than others?
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))

#Measures of rank:
#min(x), quantile(x, 0.25), max(x).
#e.g.:
#When do the first flights and last flights leave each day?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )

#Measures of position:
#first(x), nth(x, 2), last(x)
#These work similarly to x[1], x[2], and x[length(x)] but let you set a default value if that position does
#not exist (i.e. you're trying to get the third element from a group that only has two elements).  For
#example, we can find the first and last departure for each dat:
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first_dep = first(dep_time),
    last_dep = last(dep_time)
  )
#These functions are complementary to filtering on ranks.  Filtering gives you all variables, with each
#observation in a seperate row:
not_cancelled %>% 
  group_by(year, month, day) %>% 
  mutate(r = min_rank(desc(dep_time))) %>% 
  filter(r %in% range(r))

#Counts:
#We've used n() which takes no arguments and returns the size of the current group.  To count the number
#of nonmissing values, use sum(!is.na(x)).  To count the number of distinct (unique) values, use
#n_distinct(x).  E.g.:

#Which destinations have the most carriers/
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(carriers = n_distinct(carrier)) %>% 
  arrange(desc(carriers))
#Counts are so useful that dplyr provides a simple helper if all you want is a count:
not_cancelled %>% 
  count(dest)
#You can optionally provide a weight variable.  For example, you could use this to "count" (sum) the total
#number of miles a plan flew:
not_cancelled %>% 
  count(tailnum, wt = distance)

#Counts and proportions of logical values: sum(x > 10), mean(y == 0)
#When used with numeric functions, TRUE is converted into 1 and FALSE to 0.  This makes sum() and mean()
#very useful: sum(x) gives the number of TRUEs in x, amd mean(x) gives the proportion.  For example:
#How mnay flights left before 5am? (these usually indicate delayed flights from the pevious day)
not_cancelled %>%
  group_by(year, month, day) %>% 
  summarise(n_early = sum(dep_time < 500))
#What proportion of flights are delayed by more than an hour?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(hour_perc = mean(arr_delay > 60))

# ============================================================================================================
# Grouping by Multiple Variables ------------------------------------------
# ============================================================================================================

#When you group by multiple variables, each summary peels off one level of the grouping.  That makes it easy
#to progressively roll up a data set:
daily <- group_by(flights, year, month, day)
(per_day <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year <- summarise(per_month, flights = sum(flights)))
#Note: be careful when rolling up summaries.  It's OK for sums and counts, but you need to think about
#weighting means and variances.

# ============================================================================================================
# Ungrouping --------------------------------------------------------------
# ============================================================================================================

#If you need to remove grouping, and return tp operations on ungrouped data, use ungroup():

daily %>% 
  ungroup() %>% 
  summarise(flights = n())

# ============================================================================================================
# Grouped Mutates (and Filters) -------------------------------------------
# ============================================================================================================

#Grouping is most useful in conjunection with summarise(), but you can also do convenient operations
#with mutate() and filter().  For example:

#Find the worst members of each group
flights_sml %>% 
  group_by(year, month, day) %>% 
  filter(rank(desc(arr_delay)) < 10)
#Find all groups bigger than a threshold
popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n() > 365)
popular_dests
#Standardise to compute per group metrics
popular_dests %>% 
  filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay)

#A grouped filter is a grouped mutate followed by an ungrouped filter.  However, they aren't the easiest
#to use and therefore can be avoided other than for quick-and-dirty manipulations: otherwise it's hard to
#check that you've done the manipulation correclty.

# ============================================================================================================
# Chapter 5: Exploratory Data Analysis ------------------------------------
# ============================================================================================================

#EDA for short...
#EDA is an iterative cycle:
#1. Generate questions about your data
#2. Search for answers by visualising, transforming, and modelling your data
#3. Use what you learn to refine your questions and/or generate new questions

#EDA is not a formal process, with strict rules; it is a state of mind.  You should feel free to investigate
#every idea that crosses your mind.  Through hypothesis testing, you will begin to hone in on a few 
#particularly productive areas that you'll eventually write up and communicate to others.  It is fundamentally
#a creative process.

#Important questions:
#1. What type of variation occurs within my variables?
#2. What type of covariation occurs between my variables?

# Data cleaning -----------------------------------------------------------

library(tidyverse)


# Visualising Distributions -----------------------------------------------
#How you visualise the distribution of a variable depends on type of variable it is.  A categorical 
#variable takes on a small, finite set of values.  In R, categorical variables are usually saved as
#factors or character vectors.  Bar charts are typically used to visualise a categorical variable:
ggplot(diamonds) +
  geom_bar(aes(x = cut))
#The height of each bar displays how many observations occured for each x value.  You can compute
#these values manually with dplyr::count():
diamonds %>% 
  count(cut)

#A variable is continuous if it can take any of an infinite set of ordered values.  Numbers and data_times
#are two examples of continuous variables.  A histogram is typically used to view a continuous variable:
ggplot(diamonds) +
  geom_histogram(aes(x = carat), binwidth = 0.5)
#you can compute this by hand by combining dplyr:count() and ggplot::cut_width():
diamonds %>% 
  count(cut_width(carat, .5))
#A histogram divides the x-axis into equally spaced bins and then uses the height of each bar to display
#the number of observations that fall in each bin.  In the preceding graph, the tallest bar shows that almost
#30 000 observations have a carat value between .25 and .75, which are the left and right edges of the bar.

#Use bin_width() argument to set the width of the intervals in a histogram, which is measured in the units
#of the x variable.  Always explore a variety of binwidths when working with histograms, as different
#binwidths can reveal different patterns.  For example:
smaller <- diamonds %>% 
  filter(carat < 3)
ggplot(smaller, aes(x = carat)) +
  geom_histogram(binwidth = .1)

#If you wish to overlay multiple histograms in the same plot, it is recommended to use geom_freqpoly()
# as it performs the same calculation as the histogram but instead of displaying counts with bars, it uses
#lines.  It's much easier to understand and interpret when overlapped compared to a histogram:
ggplot(smaller, aes(x = carat, colour = cut)) +
  geom_freqpoly(binwidth = .1)

# Typical Values ----------------------------------------------------------
#Places that do not have bars reveal values that were not seen in your data.  To turn this information
#into useful questions, look for anything unexpected:

#   Which values are most common.  Why?
#   Which values are rare? Does that match your expectations?
#   Can you see any unusual patterns? What might explain them?

#As an example, the following histogram suggests several interesting questions:
ggplot(smaller, aes(x = carat)) +
  geom_histogram(binwidth = .01)
#   Why are there more diamomnds at whole carats and common fractions of carats?
#   Why are there more diamonds slightly to the rughts of each peak than there are slightly to the left
#   of each peak?
#   Why are there no diamonds bigger than 3 carats?

#In general, clusters of similar values suggest that subgroups exist in your data.  To understand the 
#subgroups, ask:
#   How are the observations within each cluster similar to each other?
#   How are the observations in seperate clusters different form each other?
#   How can you explain or describe the clusters?
#   Why might the appearance of clusters be misleading?


# Unusual Values ----------------------------------------------------------
#Outliers are observations that are unsual; data points that don't seem to fit the pattern.  Sometimes
#outliers are data entry errors; other times outliers suggest important new science.  When you have a
#lot of data, outliers are sometimes difficult to see in a histogram.  Fort example, take the distribution
#of the y variable from the diamonds dataset.  The only evidence of outliers in the unusuallu wide limits
#on the y-axis:
ggplot(diamonds) +
  geom_histogram(aes(x = y), binwidth = .5)
#There are so many observations in the common bins that the rare bins are so short that you can't see them.
#To make it easuer to see the unusual values, we need to zoom in to small values of the y-axis with
#coord_cartesian():
ggplot(diamonds) +
  geom_histogram(aes(x = y), binwidth = .5) +
  coord_cartesian(ylim = c(0, 50))
#coord_cartesian() also has an xlim() argument when you need to zoom into the x-axis.  ggplot also has xlim()
#and ylim() functions that work slightly differently: they throw away the data outside the limits.

#This allows us to see that there are three unusual values: 0, ~30, and ~60.  We pluck them out with dplyr:
unusual <- diamonds %>% 
  filter(y < 3 | y > 20) %>% 
  arrange(y)
unusual
#The y variable measures one of the three dimensions of these diamonds, in mm.  We know that diamonds can't
#have a width of 0mm, so these values must be incorrect.  We might also suspect that measuresments of 32mm
#and 59mm are implausible: those diamonds are over an inch long, but don't cost hundreds of thousands of
#dollars.

#It's good practice to repeat your analysis with and without outloers.  If they have minimal effect on
#the results, and you can't figure out why they're there, it's reasonable to replace them with missing
#values and move on.  However, if they have substantial effect on the results, you shouldn't drop them
#without justification.  You'll need to figure out what caused them (e.g. a data entry error etc.) and
#disclose that you removed them in your write-up.

##Exercise##
diamonds

ggplot(diamonds) +
  geom_histogram(aes(x = x), binwidth = .1) +
  coord_cartesian(ylim = c(0, 1000))

ggplot(diamonds) +
  geom_histogram(aes(x = y), binwidth = .1) +
  coord_cartesian(ylim = c(0, 50), xlim = c(15, 0))

ggplot(diamonds) +
  geom_histogram(aes(x = z), binwidth = .1) +
  coord_cartesian(ylim = c(0, 100), xlim = c(10, 0))

#Price distribution:
ggplot(diamonds) +
  geom_freqpoly(aes(x = price, colour = cut), binwidth = 1800)

#Filtering by carat:
diamonds %>% 
  filter(carat == .99 | carat == 1) %>% 
  count(carat)

# ============================================================================================================
# Missing Values ----------------------------------------------------------
# ============================================================================================================

#If you encounter unusual values in your data set, and simply want to move on with the rest of your
#analysis, you have two options:
diamonds2 <- diamonds %>% 
  filter(between(y, 3, 20))
#However, the above option is not recommeneded.  Just because one measurement is invalid, doesn't mean that
#all the measurements are invalid.  Instead, it is recommended that you replace the unusual values with
#missing values.  The easiest way to do this is to use mutate() to repalce with variable with a modified
#copy.  You can use the ifelse() function to replace unusual values with NA:
diamonds2 <- diamonds %>% 
  mutate(y = ifelse(y < 3 | y > 20, NA, y))
#ifelse() has three arguments.  The first argument test should be a logical vector.  The result will contain
#the value of the second argument, yes, when test is TRUE, and the value of the third argument, no, when
#it is false.

#Like R, ggplot warns when missing values have been excluded.  To suppress that warning, set na.rm = TRUE:
ggplot(diamonds2, aes(x = x, y = y)) +
  geom_point(na.rm = TRUE)

#Sometimes you want to understand what makes observations with missing values different from observations
#with recorded values.  For example, in nycflights13::flights, missing valies in the dep_time variable
#indicate that the flight was cancelled.  So you might want to compare the scheduled departure times for
#cancelled and noncancelled times.  You can do this by making a variable with is.na():
nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(aes(sched_dep_time)) +
  geom_freqpoly(aes(colour = cancelled),
                binwidth = 1/4)
#However, this plot isn't great because there are so many more noncancelled flights than cancelled flights.


# ============================================================================================================
# Covariation -------------------------------------------------------------
# ============================================================================================================

#Variation describes the behaviour within a variable.  Therefore, covariation describes the behaviour
#between variables.  This is the tendency for two or more variables to vary together in a related way.
#The best way to spot covariation is to visualise the relationship between two or more variables.  How you
#do this depends on the type of variables involved.


# A Categorical and Continuous Variable -----------------------------------
#It's common to want to explore the distribution of a continuous variable broken down by a categorical
#variable, as in the previous frequency polygon.  The default appearance of geom_freqpoly() is not that
#useful for that sort of comparison because the height is given by the count.  That means if one of the
#groups is much smaller than the others, it's hard to see the difference in shape.  For example, let's
#explore how the price of a diamond varies with its quality:
ggplot(diamonds, aes(x = price)) +
  geom_freqpoly(aes(colour = cut), binwidth = 500)
#It's hard to see the difference in the distribution because the overall counts differ so much:
ggplot(diamonds) +
  geom_bar(aes(x = cut))
#Therefore, to make the comparison easier we need to swap what is displayed on the y-axis.  Instead of
#displaying count, we'll display density, which is the count standardised so that the area under each
#frequency polygon us one:
ggplot(diamonds,
       aes(x = price, y = ..density..)
       ) +
  geom_freqpoly(aes(colour = cut), binwidth = 500)
#It seems that the lowest quality diamonds have the highest average price.  But that's probably because
#frequency polygons are hard to interpret - there's a lot going on in the plot.

#A boxplot is another alternative to display the distribution of a continuous variable broken down by 
#a categorical variable:
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()
#We see much less info about the distribution, but the boxplots are much more compact and so we can easily
#compare them.  It supports the counterintutive finding that better quality diamonds are cheaper on
#average.  Why?

#cut is an ordered factor: fair is worse than good, which is worse than very good, etc.  Many categorical
#variables dont have such an intrinsic order, so you might want to reorder them to make a more informative
#display.  One way to do that is with the reorder() function.  For example, take the class variable in mpg
#dataset.  You might be interested to know how highway mileage varieds across classes:
ggplot(mpg, aes(x = class, y = hwy)) +
  geom_boxplot()
#To make the trend easier to see, we can reorder class based on the median value of hwy:
ggplot(mpg) +
  geom_boxplot(
    aes(
      x  = reorder(class, hwy, FUN = median), 
      y = hwy
  )
)
#If you have long variable names, geom_boxplot() will work better if you flip it 90 degress.  You can
#do that with coord_flip():
ggplot(mpg) +
  geom_boxplot(
    aes(
    x = reorder(class, hwy, FUN = median),
    y = hwy
    )
  ) +
coord_flip()


#Use what you've learned to improve the visualisation of departure times for cancelled versus noncancelled
#flights:
nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(aes(x = sched_dep_time, y = ..density..)) +
  geom_freqpoly(aes(colour = cancelled), 
                    binwidth = 1/4) +
  coord_flip()

#What variable in the diamonds dataset is most important for predicting the price of diamonds?  How is
#that variable correlated with cut?  Why does the combination of these two relationships lead to lower
#quality diamonds being more expensive?
diamonds
ggplot(diamonds) +
  xlab("Median carat by cut") +
  geom_boxplot(
    aes(
      x = reorder(cut, carat, FUN = median), 
      y = price
     )
    ) +
  coord_flip()

#The problem with boxplots is that they were designed in an era of much smaller datasets.  lvplot is used to
#help with this problem as boxplots can hide outliers.
library(lvplot)
ggplot(diamonds) +
  xlab("Median carat by cut") +
  geom_lv(
    aes(
      x = reorder(cut, carat, FUN = median), 
      y = price
    )
  ) +
  coord_flip()

library(ggbeeswarm)
ggplot(diamonds,
       aes(
         x = price, 
         y = carat)) +
  geom_violin(aes(colour = cut))

ggplot(diamonds,
       aes(x = price)) +
  geom_histogram() +
  facet_wrap(~cut, nrow = 2)


# Two Categorical Variables -----------------------------------------------
#To visualise the covariation between categorical variables, you'll need to count the number of observations
#for each combination.  One way is to rely on the built-in geom_count():
ggplot(diamonds) +
  geom_count(aes(x = cut, y = color))

#Another approach to use is to count with dplyr:
diamonds %>% 
  count(color, cut)
#Then visualise with geom_title() and fill the aesthetic:
diamonds %>% 
  count(color, cut) %>% 
  ggplot(aes(x = color, y = cut)) +
  geom_tile(aes(fill = n))

diamonds
diamonds %>% 
  count(color, cut) %>% 
  ggplot(aes(x = color, y = cut)) +
  geom_tile(aes(fill = n), position = "identity")


# Two Continuous Variables ------------------------------------------------
#The obvious great way to visualise such a relationship is with a scatter plot.  You can see covariation
#as a pattern in the points.  For example:
ggplot(diamonds) +
  geom_point(aes(x = carat, y = price))
#However, scatter plots become less useful as the size of your data set grows.  Points begin to overplot and
#pile into areas creating a uniform of colour.  You can use the alpha aesthetic to add transparency:
ggplot(diamonds) +
  geom_point(aes(x = carat, y = price), alpha = 1/100)
#But using transparency can be challenging for very large datasets.  Another solution is to use bin.
#Previously you used geom_histogram() and geom_freqpoly() to bin in one dimension.  geom_bin2d() and
#geom_hex() can bin in two dimensions.

#geom_bin2d() and geom_hex() divide the coordinate plane into 2D bins and then use a fill colour to display
#how many points fall into each bin.  geom_bin2d() creates rectangular bins.  geom_hex() creates hexagonal
#bins.
library(hexbin)
#geom_bin2d:
ggplot(smaller) +
  geom_bin2d(aes(x = carat, y = price))

#geom_hex():
ggplot(smaller) +
  geom_hex(aes(x = carat, y = price))
#Another option is to bin one continuous variable so it acts like a categorical variable.  Then you can use
#one of the techniques for visualising the combination of a categorical and continuous variable.  For 
#example, you could bin carat anf then for each group, display a boxplot:
ggplot(smaller, aes(x = carat, y = price)) +
  geom_boxplot(aes(group = cut_width(carat, .1)))
#cut_width(x, width), as used here, divides x into bins of the value of width.  By default, boxplots look
#roughly the same (apart from the number of outliers) regardless of how many observations there are, so
#it's difficult to tell that each boxplit summarises a different number of points.  One way to make the
#width of the boxplot proportional to the number of points is with varwidth = TRUE.
ggplot(smaller, aes(x = carat, y = price)) +
  geom_boxplot(aes(group = cut_width(carat, .1)), varwidth = TRUE)
#Another approach is to display approximately the same number of points in each bin.  That's the job of
#cut_number():
ggplot(smaller, aes(x = carat, y = price)) +
  geom_boxplot(aes(group = cut_number(carat, 20)))

#1. Instead of summarising the conditional distribution with a boxplot, you could use a freq_poly.  What
#   do you need to consider when using cut_width() versus cut_number()? How does that impact a visualisation
#   of the 2D distribution of carat and price?
ggplot(smaller, aes(x = carat)) +
  geom_freqpoly(aes(group = cut_width(carat, 50)))

ggplot(smaller, aes(x = carat)) +
  geom_freqpoly(aes(group = cut_number(carat, .1)))
# The distribution is not suprising.  The heavier the diamond, the greater the cost.

#2. Visualise the distribution of carat, partitioned by price.
ggplot(smaller, aes(x = carat, y = price)) +
  geom_boxplot(aes(group = cut_number(carat, 20)), varwidth = TRUE) +
  coord_flip()
#3. Combine two of the techniques you've ;earned to visualise the combined distribution of cut, carat, and
#   price.
ggplot(smaller,aes(x = carat, y = price)) +
  geom_point(aes(colour = cut, size = price), position = "jitter", alpha = .6) +
  coord_flip()

ggplot(smaller, aes(x = carat, y = price)) +
  geom_boxplot(aes(fill = cut), varwidth = TRUE) +
  coord_flip()
#5. Two-dimensional plots reveal outliers that are not visible in one_dimensional plots.  For example, some
#   points in the following plot have an unusual combo of x and y values, which makes the points outliers
#   even though their x and y values appear normal when examined seperately:
ggplot(diamonds) +
  geom_point(aes(x = x, y = y)) +
  coord_cartesian(xlim = c(4, 11), ylim = c(4, 11))
#A binned plot would not be able to accurately display the distribution between two continuous variables.


# Patterns and Models -----------------------------------------------------
#Patterns in your data provide clues about relationships.  If a systematic relationship exists between two
#variables it will appear as a pattern in the data.  If you spot a pattern, ask yourself:
#   Could this pattern be due to coincidence (i.e. random chance)?
#   How can you describe the relationship implied by the pattern?
#   How strong is the relationship implied by the pattern?
#   What other variables might affect the relationship?
#   Does the relationship change if you look at individual sub-groups of the data?

#A scatterplot of Old Faithful lengths versus the wait time between eruptions shows a pattern: longer wait
#times are associated with longer eruptions.  The scatterplot below also displays the two clusters that we
#noticed earlier:
ggplot(faithful) +
  geom_point(aes(x = eruptions, y = waiting))
#Patterns provide one of the most useful tools for data science because they reveal covariation.  If you 
#think of variation as a phenomenon that increases uncertainity, you can think of covariation as a 
#phenomenon that reduces it.  If two variables covary, you can use the values of one variable to make
#better predicitions about the values of the second.  If the covariation is due to a causal relationship
#(a special case), then you can use the value of one variable to control the value of the second.

#Models are tools for extracting patterns out of data.  For example, consider the diamonds data.  It's hard
#to understand the relationship between cut and price, because cut and carat, and carat and price, are 
#tightly related.  It's possible to use a model to remove the very strong relationship between the price
#and carat so we can explore the subtleties that remain.  The following code fits a model that predicts
#price from carat and then computes the residuals (the difference between the predicted value and the actual
#value).  The residuals give us a view of the price of the diamond, once the effect of carat has been
#removed:
library(modelr)
mod <- lm(log(price) ~ log(carat), diamonds)
diamonds2 <- diamonds %>% 
  add_residuals(mod) %>% 
  mutate(resid = exp(resid))

ggplot(diamonds2) +
  geom_point(aes(x = carat, y = resid), position = "jitter", alpha = 1/4)

#Once you've removed the strong relationship between carat and price, you can see what you expect in the 
#relationship between cut and price - relative to their size, the better quality diamonds are more 
#expensive.
ggplot(diamonds2) +
  geom_boxplot(aes(x = cut, y = resid))


# ggplot Calls ------------------------------------------------------------
#We will move on to learn a more precise expression og ggplot syntax
diamonds %>% 
  count(cut, clarity) %>% 
  ggplot(aes(clarity, cut, fill = n)) +
  geom_tile()


# ============================================================================================================
# Chapter 6: Projects -----------------------------------------------------
# ============================================================================================================

getwd()

ggplot(diamonds, aes(carat, price)) +
  geom_hex()
ggsave("diamonds.pdf")

write_csv(diamonds, "diamonds.csv")



# Part III: Wrangle -------------------------------------------------------
#Data wrangling: the art of getting your data into R in a useful form for visualisation and modeling. 


# Chapter 7: Tibbles with tibble ------------------------------------------
#Tibbles are data frames, but they tweak some older behaviours to make life a little easier.  
vignette("tibble")

#Most other R packages use regular data frames, so you might want to coerce a data frame to a tibble.  You 
#can do that with as_tibble():
as_tibble(iris)

#You can create a new tibble from individual vectors with tibble().  tibble() will automatically recycle
#inputs of length 1, and allows you to refer to variables that you just created, as shown here:
tibble(
  x = 1:5,
  y = 1,
  z = x ^ 2 + y
)=0
#Note: tibble does much less in comparison to data frame.  It never changes the type of the inputs (e.g. it
#never coverts strings to factors!), it never changes the names of the variables, and it never creates
#row names.

#It's possible for a tibble to have column names that are not valid R variable names, aka nonsyntactic names.
#For example, they might not start ith a letter or they mught contain unusual characters, like a space. To
#refer to these variavkes, you need to surround them with backticks, ``:
tb <- tibble(
  `:)` = "smile",
  ` ` = "space",
  `2000` = "number"
)
tb
#You will also need these backticks when working with these variables in other packages, like ggplot, dplyr,
# and tidyr.

#Another way to create a tibble is with tribble(), short for tranposed tibble.  tribble() is customised for
#data entry in code: column headings are defined by formulas (i.e. they start with ~), and entries are
#seperated by commas.  This makes it possible to lay out small amounts of data in easy-to-read form:
tribble(
  ~x, ~y, ~z,
#   --/--/--
  "a", 2, 3.6,
  "b", 1, 8.5
)
#Note: adding a line commend when making a tibble can help male it clearer as to where the header is.

#There are two main differences in the usage of a tibble versus a classic data.frame: princting and
#subsetting.


# Printing ----------------------------------------------------------------
#Tibbles have a refined print method that shows only the first 10 rows, and all the columns that fit on the
#screen.  This makes it much easier to work with large data.  In addition to its name, each column reports
#its type, a nice feature borrowed from str():
tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)
#tibbles are designed so that you don't accidently overwhelm your console when you print large data.frames.
#But sometimes, you need more output than the default display.

#You can explicitly print() the data frame and control the number of rows (n) and the width of the display.
#width = Inf will display all columns:
nycflights13::flights %>% 
  print(n = 10, width = Inf)


#My preferred option to view the whole data set is with the classic View():
nycflights13::flights %>% 
  View()


# Subsetting --------------------------------------------------------------
df <- tibble(
  x = runif(5),
  y = rnorm(5)
)
#Extract by name:
df$x
df[["x"]]
#Extract by position:
df[[1]]
#Compared to data.frames, tibbles are ore strict: they never do partial matching, and they will generate a 
#warning if the column you are trying to acess does not exist.


# Interacting with Older Code ---------------------------------------------
#Some older functions don't work with tibbles.  If you encounter one of these functions, use as.data.frame()
#to turn a tibble back to a data.frame()

class(as.data.frame(tb))
#The main reason that some older functions don't work with tibbles is that [ function.  We don't use [ much
#in this book because dplyr::filter() and dplyr::select() allow you to solve the same problems with clearer
#code.  With base R data frames, [ sometimes returns a data frame, and sometimes returns a vector.  With
#tibbles, [ always returns another tibble.


# Chapter 8: Data Import and readr ----------------------------------------
#Here you use the readr package.  This is found in the tidyverse package.  Most of readr's functions are
#concerned with tyrbing flat files into data frames:

#read_csv() reads a comma-delimitted files
#read_csv2() reads semicolon-seperated files
#read_tsv() reads tab-deliminated files
#read_delim() reads files in any delimiter
#read_fwf() reads fixed-width filesl; you can specifiy widths with either fwf_widths() or their position with
#fwf_positions().
#read_table() reads a common variation of fixed-width files where columns are seperated by white space.
#read_log() reads Apache style log files

#You can also supply an inline CSV file.  This is useful for experimenting with readr and for creating
#reproducible examples to share with others:
read_csv("a, b, c
         1, 2, 3
         4, 5, 6")
#Note the first line of data being used to designate column names in the tibble.  There are cases however,
#where you might want to tweak this behaviour:

#1. Sometimes therea are a few lines of metadata at the top of the file.  You can use skip = n to skip the first
#n lines; or use comment = "#" to drop all lines that start with, for example, #:
read_csv("The first line of metadata
         The second line of metadata
         x, y, z
         1, 2, 3", skip = 2)
read_csv("# A comment I want to skip
         x, y, z
         1, 2, 3", comment = "#")
#2. The data might not have column names.  You can use col_names = FALSE to tell read_csv() not to treat the
#first row as headings, and instead label them sequentially from x1 to xn:
read_csv("1, 2, 3\n4, 5, 6", col_names = FALSE)
#"\n" is a shortcut for adding a new line.

#Alternatively, you can pass col_names() a character vector, which will be used as the column names:
read_csv("1, 2, 3\n4, 5, 6", col_names = c("x", "y", "z"))

#Another option that commonly needs tweaking is na.  This specifies the value (or values) that are used
#to represent missing values in your file:
read_csv("a, b, c\n1, 2,.", na = ".")



# Parsing a Vector --------------------------------------------------------
#parse_*() functions take a character vector and return a more specialised vector like a logical, integer,
#or date:
str(parse_logical(c("TRUE", "FALSE", "NA")))
str(parse_integer(c("1", "2", "3")))
str(parse_date(c("2010-01-01", "1979-10-14")))
#These functions are useful in their own rights, but are also an important building block for readr.
#understanding how these individual parsers work helps to see how they fit together to parse a complete
#file.

#Like all functions in the tidyverse, the parse_*() functions are uniform; the first argument is a character
#vector to parse, and the na argument specifies which strings should be treated as missing:
parse_integer(c("1", "231", ".", "456"), na = ".")
#If parsing fails, you will get a warning:
x <- parse_integer(c("123", "345", "abc", "123.45"))
#And the failures will be missing in the output:
x
#If there are many parsing failures, you'll need to use problems() to get the complete list.  This returns
#a tibble, which you can them manipulate with dplyr:
problems(x)
#Using parsers is mostly a matter of understanding what's available and how they deal with different types
#of input.  There are eight particularly important parsers:

#parse_logical() and parse_integer() parse logicals and integers, respectively.

#parse_double() is a strict numeric parser, and parse_number() os a flexible numeric parser.  These are
#more complicated than you might expect because different parts of the world write numbers in different
#ways.

#parse_character() seems simple, however character encodings make it complex. See section below.

#parse_factor() creates factors, the data structures that R uses to represent categorical variables with
#fixed and known values.

#parse_datetime(), parse_date(), and parse_time() allow you to parse various date and time specifications.
#These are the most complicated because there are so many different ways of writing dates.


# Parsing Numbers ---------------------------------------------------------
#It seems like it should be straightforward to parse a number, but three problems make ti tricky:

#1. People write numbers differently in different parts of the world.  For example, some countries use . in
#   betweem the integer and fractional parts of a real number, while others use , .
#2. Numbers are often surrounded by other characters that provide some context, like $1000 or 10%.
#3. Numbers often contain 'grouping' characters to make them easier to read, like '1, 000, 000', and
#   these grouping characters vary around the world.

#To address the first problem, readr has the notion of a 'locale', an object that specifies parsing options
#that differ from place to place.  When parsing numbers, the most important option is the character you
#use for the decimal mark.  You can override the default value of . by creating a new locale and setting the
#decimal_mark argument:
parse_double("1.23")
parse_double("1,23", locale = locale(decimal_mark = ","))

#parse_numer() addresses the second problem: it ignores non-numeric characters before and after the number.
#This is particularly useful for currencies and percentages, but also works to extract numbers embedded
#in text:
parse_number("$100")
parse_number("20%")
parse_number("It cost $123.45")

#The final problem is addressed by the combination of parse_number() and the locale as parse_number() will
#ignore the 'grouping mark':

#Used in the States:
parse_number("$123,456,789")
#Used in many parts of Europe:
parse_number(
  "123.456.789",
  locale = locale(grouping_mark = ".")
)
#Used in Switaerland:
parse_number(
  "123'456'789",
  locale = locale(grouping_mark = "'")
)


# Strings -----------------------------------------------------------------
#parse_character() seems simple.  However, because there are multiple ways to represent the same string it
#isn't.  We can understand this by looking into how computers represent strings.  In R, we can get at the
#underlying representation of a string using charToraw():
charToRaw("Hadley")
#Each hexadecimal number represents a byte of info: 48 is H, 61 is a, and so on.  The mapping from 
#hexidecimal number to character is called the encoding, and in this case, the encoding is called
#ASCII.  ASCII easilhy represents English charcaters.  Things get more complex for other languages.
#This is especiallh so when one uses data that was encoded before UTF-8.  If this happnens, strings
#will look weird when you print them.  Sometimes, just one or two characters might be messed up;
#other times you'll get complete gibberish.  For example:
x1 <- "El Ni\xf1o was particularly bad this year"
x2 <- "\x82\xb1\x82\xc9\x82\xbf\x82\xcd"
#To fix this problem you need to specify the encoding in parse_character():
parse_character(x1, locale = locale(encoding = "Latin1"))
parse_character(x2, locale = locale(encoding = "Shift-JIS"))
#How do you determine the coding type?  Well, sometimes this is found in the data documentation.
#Unfortunately, this is rarely the case, so readr provides guess_encoding() to help you figure it out.
#Expect to try a few different encodings before you figure it out.
guess_encoding(charToRaw(x1))
guess_encoding(charToRaw(x2))
#the first argument to guess_encoding() can either be a path to a file or, as in the case, a raw vector.


# Parsing Factors ---------------------------------------------------------
#R uses factors to represent categorical variables that have a known set of possible values.  Give 
#parse_factor() a vector of known levels to generate a warning whenever an unexpected value is present:
fruit <- c("apple", "banana")
parse_factor(c("apple", "banana", "bananana"), levels = fruit)
#However, if you have many problematic entries, it's easier to use the tools you learn in the proceding
#chapters.


# Parsing Dates, Dates-Times, and Times -----------------------------------
#You pick between three parsers depending on whether you want a date, a date-time, aor a time.  When called
#with any additional arguments:

#parse_datetime() expects an ISO8601 date-time.  ISO8601 is an international standard in which components of
#a date are organised in a descending manner: year, month, day, hour, minute, second:

parse_datetime("2010-10-01T22010")
#If time is omitted it will be set to midnight
parse_datetime("20101010")
#This is the most important date-time standard.

#parse-date() expects a four-digit year, a - or /, th month, a - or /, then a day:
parse_date("2010-10-01")

#parse_time() expects the hour, :, minutes, optionally : and seconds, and an optional a.m./p.m. specifier:
library(hms)
parse_time("01:10 am")
parse_time("20:10:01")
#Base R doesnm't have a great built-in class for time data, so we use the one provided in the hms package.


# Parsing a File: ---------------------------------------------------------
#readr uses a heursitc to figure out the type of each column: it reads the first 1000 rows.  You can
#emulate this process with a character vector using guess_parser() , which returns readr's best guess,
#and parse_guess(), which uses that guess to parse the column:
guess_parser("2010-10-01")
guess_parser("15:01")
guess_parser(c("TRUE", "FALSE"))
guess_parser(c("1", "5", "9"))
guess_parser("12,352,561")
str(parse_guess("2010-10-01"))


# Problems with Parsing Files --------------------------------------------
#Guessing might no always work due to a large file or missing values.  For example:
challenge <- read_csv(readr_example("challenge.csv"))
problems(challenge)
#A good strategy is to work column by column until there are no problems remaining.  Here we can see that
#there are a lot of  parsing problems with the column x - there are trailing characters after the interger
#value.  That suggests we need to use a double parser instead.

#To fix the call, start by copying and pasting the column specification into your original call:
challenge <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(
    x = col_integer(),
    y = col_character()
  )
)
#Then you can tweak the type of x column:
challenge <- read_csv(
  readr_example('challenge.csv'),
  col_types = cols(
    x = col_double(),
    y = col_character()
  )
)
#That fixes the first problem, but if we look at the last few rows, you'll see thast they're dates stored
#in a character vector:
tail(challenge)
#You can fix that by specifying that y is  adate column:
challenge <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)
tail(challenge)
#Every parse_xyz() function has a corresponding col_xyz() function.  You use parse_xyz() when the data is in
#a character bector in R already; you use col_xyz() when you want to tell readr how to load the data.

#It is suggested to always supply col_types =, building up from the printout privuded by readr.  This ensures
#that you have a consistent and reproducible data import script.  If you rely on the default guesses and
#your data changes, readr will continue to read it in.  If you want to be really strict, use
#stop_for_problems(): that will throw an error and stop your script if there are any parsing problems.


# Other Parsing Strategies ------------------------------------------------
#In the previous example, we just got unlucky: if we look at just one more row than the default, we can
#correctly parse in one shot:
challenge2 <- read_csv(
  readr_example("challenge.csv"),
  guess_max = 1001
)
challenge2

#Sometimes it's easier to diagnose problems if you just read in all the columns as character vectors:
challenge2 <- read_csv(readr_example("challenge.csv"),
                       col_types = cols(.default = col_character())
)
#This is particularly useful in conjunction with type_covert(), which applies the parsing heuristicds to 
#the character columns in a data frame:
df <- tribble(
  ~x, ~y,
  "1", "1.21",
  "2", "2.32",
  "3", "4.56"
)
df
#Note column types (chr)
type_convert(df)
#If you're reading a very large file, you might want to set n_max to a smallish number like 10, 000 or
#100, 000.  That will accelerate your iterations while you eliminate common problems.
#If you're having major parsing problems, sometimes it's easier to just read into a character vector of lines
#with read_lines(), or even a character vector of length 1 with read_file().  Then you can use the string
#parsing skills you'll learn later to parse more exotic formats.


# Writing to a file -------------------------------------------------------
#readr also comes with two useful functions for writing data back to disk: write_csv() and write_tsv().
#Both functions increase the chances of the output file being read back incorrectly by: 
#   Always encoding strings in UTF-8
#   Saving dates and date-times in ISO8601 format so they are easily parsed elsewhere.

#To export a CSV file to Excel, use write_excel_csv().  This write a special character (a 'byte order mark')
#which tells excel that you're using the UTF-8 encoding.

#The most important arguments are x(the data frame to save) and path(the location to save it).  You can 
#also specify how missing values are written with na, and if you want to append an existing file:
write_csv(challenge, "challenge.csv")
#Note that the type of info is lost when you save to CSV:
challenge
write_csv(challenge, "challenge-2.csv")
read_csv("challenge-2.csv")
#Thus makes CSV's a little inreliable for caching interim results - you need to re-create the column
#specification every time you load in.  There are two alternatives:

# write_rds() and read_rds() are uniform wrappers around the base functions readRDS() and saveRDS().  These
# store data in R's custom binary format called RDS:
write_rds(challenge, "challenge.csv")
read_rds("challenge.csv")

#The feather package implements are fast binary file format that can be shared across programming languages:
library(feather)
write_feather(challenge, "challenge.feather")
read_feather("challenge.feather")
#feather tends to be faster than RDS and is usable outside or R.  RDS supports list-columns, feather
#currently doesn't.


# Other Types of Data -----------------------------------------------------

#haven reads SPSS, Stata, and SAS files
#readxl reads excel files
#DBI, along with database-specific backend allows you to run SQL queries against a database and return a
#data frame

# ============================================================================================================
# Chapter 9: Tidy Data with tidyR -----------------------------------------
# ============================================================================================================

#Once you have tidy data, you will spend much less time munging data from one representation to another, 
#allowing you to spend more time on analytic questions.
library(tidyverse)


# Tidy Data ---------------------------------------------------------------
table2
table3
table4a
table4b

#These are all representations of the same underlying data, but they are not equally easy to use.  One 
#dataset, the tidy dataset, will be much easier to work with inside the tidyverse.

#There are three interrelated riles which make a dataset a tidy:
#1. Each variable must have its own column
#2. Each observation must have its own row
#3. Each value must have its own cell

#A dataset has to satisfy all three in order to be a tidy.  This leads to an even simpler set of practical
#instructions:
#1. Put each dataset in a tibble
#2. Put each variable in a column

#In this example, only table1 is a tidy.  It's the only representation where each column is a variable.
#Why ensure your data is tidy?  There are two main advantages:
#1. There's a general advantage to picking one consistent way of storing data.  If you have consistent data
#   structure, it's easier to learn the tools that work with it because they have an underlying uniformity.
#2. There's a specific advantage to placing variables in columns because it allows R's vectorised nature to
#   shine.  Most built-in R functions work with vectors of values.  That makes transforming tidy data feel
#   particularly natural.

#dplyr, ggplot, and all other packages in the tidyverse are designed to work with tidy data,  Here are a
#couple of small examples showing how you might work with table1:

#Compute rate per 10,000
table1 %>% 
  mutate(rate = cases / population * 10000)
#Compute cases per year
table1 %>% 
  count(year, wt = cases)
#Visualise changes over time
ggplot(table1, aes(year, cases)) +
  geom_line(aes(group = country), colour = "grey50") +
  geom_point(aes(colour = country))


#Compute the rate for table2, and table4a + table4b:
t2_cases <- table2 %>% 
  filter(type == "cases") %>% 
  rename(cases = count) %>% 
  arrange(country, year)
t2_pop <- table2 %>% 
  filter(type == "population") %>% 
  rename(population = count) %>% 
  arrange(country, year)

t2rate_table <- tibble(
  year = t2_cases$year,
  country = t2_cases$country,
  cases = t2_cases$cases,
  population = t2_pop$population
) %>% 
  mutate(prevalence = cases / population * 10000) %>% 
  select(country, year, prevalence)
t2rate_table
#To store this new variable in the appropriate location, we will add new rows to table2.
t2_cases_per_cap <- t2rate_table %>% 
  mutate(type = "prevalence") %>% 
  rename(count = prevalence)

table2_final <- bind_rows(table2, t2_cases_per_cap) %>% 
  arrange(country, year, type, count)
table2_final

table4a
table4b

table4c_rate <- tibble(
  country = table4a$country,
  `1999 rate` = table4a[["1999"]] / table4b[["1999"]] * 10000,
  `2000 rate` = table4a[["2000"]] / table4b[["2000"]] * 10000
)
table4c_rate

#recreate the plot showing the change in cases over time using table2 instead of table1.
table2 %>% 
  filter(type == "cases") %>% 
  ggplot(aes(year, count)) +
  geom_line(aes(group = country), colour = "grey50") +
  geom_point(aes(colour = country)) +
  scale_x_continuous(breaks = unique(table2$year)) +
  ylab("cases")


# Spreading and Gathering -------------------------------------------------
#The first step to tidying your data is to fugure out what the variables and observations are.  The second
#step is to resolve one of two common problems:
# One variable might be spread across multiple columns
# One observation might be spread across multiple rows

#To fix these problems, you'll need to know the two most important functions, gather() and spread().


# Gathering ---------------------------------------------------------------
#A common problem is a dataset where some of the column names are not names of variables but values.  For
#example, table4a:
table4a
#To tidy a dataset like this, we need to gather those columns into a new pair of variables.  To describe 
#that operation, we need three parameters:
# The set of columns that represent valies, not variables.  In this example, those are columns 1999 & 2000.
# The name of the variable whose values form the column names.  We will call it key, and here it is year.
# The name of the variable whose values are spread over the cells.  We call that value, and here it is 
# the number of cases

#Note: nonsyntactic names are designated with `` and not "".
table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")
table4b
table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")
#To combine the tidied versions, you need to use dplyr::left_join():
tidy4a <- table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")
tidy4b <- table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")
left_join(tidy4a, tidy4b)  



# Spreading ---------------------------------------------------------------
#Spreading is the opposite of gathering().  You use it when an observation is scattered across multiple rows.
#For example, take table2 - an observation is a country in a year, but each obsrrvation is spread across two
#rows:
table2
#To tidy this up, we first analyse the representation in a similar way to gather().  Howeverm we only need
#two parameters:
# The column that contains variable names, the key column.
# The column that contains values that form multiple variables, the value column.

#Note: spread() and gather() and complimnent functions.  spread() makes long tables shorter and wider;
#gaher() makes wide tables narrower and longer.

spread(table2, key = type, value = count)

#Why are gather() and spread() not perfectly symmetrical?  Consider the following example:
stocks <- tibble(
  year = c(2015, 2015, 2016, 2016),
  half = c(  1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks
stocks %>% 
  spread(year, return) %>% 
  gather("year", "return", `2015`:`2016`)



# Seperating and Pulling --------------------------------------------------
#Seperating is when there is one column taht contains two variables.  The compliment to the seperate ()
#function is unite(); which you use if a single variable is spread across multiple columns.


# Separate ----------------------------------------------------------------
#The separate() function pulls apart on column into multiple columns, by splitting whatever a separator
#character appears.  Take table3:
table3
#The rate column contains both cases and population variables, and we need to split it into two variables.
#separate() takes the name of the column to separate, and the names of the columns to separate into:
table3 %>% 
  separate(rate, into = c("cases", "population"))
#By default, separate() will split values wherever it sees a non-alphanumeric character(i.e. a character) 
#that isn't a number or a letter).  For example, in the preceding code, separate() split the values of rate
#at the forward slash characters.  If you wish to use a specific character to separate a column, you can
#pass the character to the sep argument of separate(),  For example, we could rewrite the preceding code as:
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")
#Notice that the cases and population columns are charcater columns.  This is the default.  However, in this
#case, it is not useful as those are really numbers.  We can use separate() to try and convert to better 
#types using convert = TRUE:
table3 %>% 
  separate(
    rate,
    into = c("cases", "population"),
    convert = TRUE
  )
#You can also pass a vector of integers to sep.  separate() will interpret the integers as positions to split
#at.  Postive values start at 1 on the far left of the strings; negative values start at -1 on the far right
#of the strings.  When using integers to separate things, the length of the sep should be one less than the
#number of the names in into:
table3 %>% 
  separate(
    year,
    into = c("century", "year"),
    sep = 2
  )
#You can use this arrangement to separate the last two digits of each year.  This makes this data less tidy,
#but is useful in other cases.


# Unite -------------------------------------------------------------------
#unite() is the inverse of separate(): it combines multiple columns into a single column.  You'll need it
#much less frequently than separate(), although it is still a useful tool to have.

#We can yse unite() to rejoin century and year columns that we created in the last example.  That data is
#saved as tidyr::table5.  unite() takes a data frame, the name of the new variable to create, and a set of
#columns to combine, again specified in dplyr::select():
table5 %>% 
  unite(new, century, year)
#In this case, we alos need to use the sep argument.  The default will place an underscore between the values
#from different columns.  Here, we don't want any separator so we use "":
table5 %>% 
  unite(new, century, year, sep = "")


# Missing Values ----------------------------------------------------------

#A valur can be missing in one of two possible ways:
# Explicitly; i.e. flagged with an NA
# Implicitly; i.e. simply not present in the data

#For example:
stocks <- tibble(
  year = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr  = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66)
)
stocks
#There are two missing values in the dataset:
# The return for the fourth quarter of 2015 is explicitly missing, because the cell where its value should
# be instead contains NA.

# The return for the first quarter of 2016 is implicitly missing, because it simply does not appear in the
# dataset.
#One way to think about the difference iw with the Zen-like kian: an explicit missing value is the presence
#of an absence; an implicit missing value is the absence of a presence.

#The way that a dataset us represented can make the implicit values explicit.  For example, we can make the
#implicit missing value explicit by putting years in the columns:
stocks %>% 
  spread(year, return)
#Because these explicit missing values may not be important in other representations of the data, you can
#set na.rm = TRUE in gather() to turn explicit missing values implicit:
stocks %>% 
  spread(year, return) %>% 
  gather(year, return, `2015`:`2016`, na.rm = TRUE)
#Another important tool for making missing values explicit in tidy data is complete():
stocks %>% 
  complete(year, qtr)
#complete() takes a set of columns, and finds all unique combinations.  It then ensures the original dataset
#contains all those values, filling in explicit NA where necessary.

#There's one other important tool for working with missing values.  Sometimes when a data source has
#primarily been used for data entry, missing values indicate that the previous value should be carried
#forward:
treatment <- tribble(
  ~person,             ~treatment, ~response,
  "Derrick Whitemore", 1,          7,
  NA,                  2,         10, 
  NA,                  3,          9, 
  "Katherine Burke",   1,          4
)
#You can fill in these misisng values with fill().  fill() takes a set of columns where you want missing
#values to be replaced by the most recent nonmissing value (sometimes called the last observation carried
#forward):
treatment %>% 
  fill(person)


# Case Study: WHO ---------------------------------------------------------
#This case study comes from the 2014 World Health Organisation Global TB Report.  There's a wealth of
#epidemiological info in this dataset, but it's challenging to work with the data in the form that it;'s
#provided:
who
#This is a very typical real-life dataset.  It contains redundant columns, odd variable codes, and many
#missing values.  In short, who is messy, and we'll need multiple steps to tidy it.  Like dplyr, tidyr is
#designed so that each function does on thing well.  That means in real-life situations you'll usually
#need to string together multiple verbs into a pipeline.

#The best place to start is almost always to gather together the columns that are not variables:
View(who)
#   It looks like country, iso2, and iso3 are three variables that reduntantly specify the country.  
#   year is clearly also a variable
#   We don't know that all the other columns are yet, but given the structure in the variable names (e.g.
#   new_sp_m014, new_ep_m014, new_ep_f014) these are likely to be values, not variables.

#So we need to gather together all the columns from new_sp_m014 to newrel_f65.  We don't know what those
#represent yet, so we'll give them the generic name "key".  We know the cells represent the count of cases
#, so we'll use the variable cases.  There are a lot of missing values in the current representation, so for
#now we'll use na.rm just so we can focus on the values that are present:
who1 <- who %>% 
  gather(
    new_sp_m014:newrel_f65, key = "key",
    value = "cases",
    na.rm = TRUE
  )
who1
#We can get some hint of the structure of the values in the new key column by counting them:
who1 %>% 
  count(key)
#We need to make a minor fix to the format of the column names; unfortunately the names are slighlty 
#inconsistent because instead of new_rel we have newrel.  We can use str_replace().
who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
who2
#We can separate the values in each code with two passes of separate().  The first pass will split the codes
#at each underscore:
who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")
who3
#Then we might as well drop the new column because it's constant in this dataset.  While we're dropping
#columns, let's also drop iso2 and iso3 since they're redundant:
who3 %>% 
  count(new)
who4 <- who3 %>% 
  select(-new, -iso2, -iso3)
who4
#Next, we can separate sexage into sex and age by splitting after the first charcater:
who5 <- who4 %>% 
  separate(sexage, c("sex", "age"), sep = 1)
who5
#The data set is now tidy!
View(who)
#Although we did this one step at a time, it is better to build up a complex pipe:
who %>% 
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(
    code = stringr::str_replace(code, "newrel", "new_rel")
  ) %>% 
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)



# ============================================================================================================
# Chapter 10: Relational Data with dplyr ----------------------------------
# ============================================================================================================

#It's rare that a data analysis involves only a single table of data.  Typically, you will have many tables
#of data, and you must combine them to answer the questions that you're interested in.  These collective
#tables are called relational data, because it is the relations and not just the individual data sets
#that are important:

#   Mutatuting joins, add new variables to one data from matching observations in another.
#   Filtering joins, which filter observations from one data frame based on whether ot not they match an
#   observation in the other table.
#   Set operations, which treat observations as if they were set elements.

library(tidyverse)
library(nycflights13)

airlines
airports
planes
weather


# Keys --------------------------------------------------------------------
# The variables used to connect each pair of tables are called keys.  A key is a variable, or set of variables,
# that uniquely indentifies an observation:

#   A Primary Key: uniquely idenitifies an observation in its own table.
#   A Foreign Key: uniquely indentifies an observation in another table.

# A variable can be both a primary and a foreign key.

# Once you've identified the primary keys in your tables, it's good practice to verify that they do indeed
# uniquely identify each observation.  One way to do that is count() the primary keys and look for entries
# where n is greater than one:
planes %>% 
  count(tailnum) %>% 
  filter(n > 1)

weather %>% 
  count(year, month, day, hour, origin) %>% 
  filter(n > 1)

# Sometimes a table doesn't have an explicit primary key: each row is an observation, but no combination of
# variables reliably identifies it.  For example, what's the primary key in the flights table?  You might
# think it would be the date plus the origin or tail number, but neither of those are unique:
flights %>% 
  count(year, month, day, flight) %>% 
  filter(n > 1)

flights %>% 
  count(year, month, day, tailnum) %>% 
  filter(n > 1)

# If a table lacks a primary key, it's sometimes useful to add one with mutate() and row_number().  That
# makes it easier to match observations if you've done some filtering and want to check back in with the
# original data.  This is called a surrogate key.

# A primary key and the corresponding foreign key in another table form a relation.  Relations are typically
# one-to-many.  For example, each flight has one plane, but each plane has many flights.  In other data,
# you'll occasionally see a 1-to-1 relationship.  You can think of this as a special case of a 1-to-many.
# You can model many-to-many relations with a many-to-1 relation plus a 1-to-many relation.  For example,
# in this data there's a many-to-many relationship between airlines and airports; each airline flies to
# many airports; each airport hosts many airlines.



# Mutating Joins ----------------------------------------------------------
# Mutating join allows you to combine variables from two tables.  It first matches observations by their keys
# and then copies across variables from one table to the other.

# Like mutate(), the join functions add variables to the rught, so if you have a lot of variables already,
# the new variables won't get printed out.  
flights2 <- flights %>% 
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2
# For example, let's add the full airline name to the flights2 data.  You can combine the airlines and
# flights2 data frames with left_join():
flights2 %>% 
  select(-origin, -dest) %>% 
  left_join(airlines, by = "carrier")

# You could have got to the same place using mutate() and R's base subsetting:
flights2 %>% 
  select(-origin, -dest) %>% 
  mutate(name = airlines$name[match(carrier, airlines$carrier)])


# Understanding Joins -----------------------------------------------------
x <- tribble(
  ~key, ~val_x,
  1, "1",
  2, "2",
  3, "3"
)

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  3, "y3"
)


# Inner Join --------------------------------------------------------------
# An inner join matches pairs of observations whenever their keys are equal (or equijoin):
x %>% 
  inner_join(y , by = "key")
# The most important proerty of an inner join is that unmatched rows are not included in the result.  This
# means that generally inner joins are usually not appropriate for use in analysis because it's to oeasy to
# lose observations.


# Outer Joins -------------------------------------------------------------
# An inner join keeps observations that appear in both tables.  An outer join keeps observations that appear
# in at least one of the tables.  There are three types of outer joins:
# A left join keeps all observations in x.
# A right join keeps all observations in y.
# A full join keeps all observations in x and y.

# These joins work by adding an additional 'virtual' observation to each table.  This observation has a key
# that always matches (if no other key matches), and a value filled with NA

# The most commonly used join is the left join: you use this whenever you look up additional data from 
# another table, because it preserves the original observations even when there isn't a match.  The left
# join should be your default.


# Duplicate Keys ----------------------------------------------------------
# Keys are not always unique.  If there are duplicate keys., this can create multiple observations of the
# same data point.


# Defining Key Columns ----------------------------------------------------
# The default, by = NULL, uses all variables that appear in both tables, the so-called natural join.
# For example:
flights2 %>% 
  left_join(weather)
# A character vector, by = "x".  This is like a natural join, but uses only some of the common variables.
# For example, flights and planes have year variables, but they mean different things so we only want to 
# join by tailnum:
flights2 %>% 
  left_join(planes, by = "tailnum")
# Note: the year variables (which appear in both input data frames, but are not considered to be equal) are
# disambiguated in the output with a suffix.

# A named character vector: by = c("a" = "b").  This will match variable a, in table x, to variable b, in
# table y.  The variables from x will be used in the output. 
flights2 %>% 
  left_join(airports, c("dest" = "faa"))
# and
flights2 %>% 
  left_join(airports, c("origin" = "faa"))

# 1. Compute the average delay bu destination, then join on the airports data frame so you can show the 
#   spatial distribution of delays.
flights %>% 
  select(arr_delay, dest) %>%
  group_by(dest) %>%
  filter(arr_delay > 0) %>% 
  summarise(mean_delay = mean(arr_delay, na.rm = TRUE)) %>%  
  left_join(airports, c("dest" = "faa")) %>% 
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point(aes(size = mean_delay, alpha = 1/5), 
             show.legend = FALSE) +
  coord_quickmap()

# What weather conditions make it more likely to see a delay?
flight_weather <- flights %>% 
  left_join(weather) %>% 
  select(dep_delay, day, temp:visib) %>% 
  group_by(day) %>% 
  summarise(
    mean_temp = mean(temp, na.rm = TRUE),
    mean_visib = mean(visib, na.rm = TRUE),
    mean_depdelay = mean(dep_delay, na.rm = TRUE),
    mean_precip = mean(precip, na.rm = TRUE),
    ) %>% 
  arrange(desc(mean_depdelay))

flight_weather %>%
  ggplot(aes(x = mean_precip, y = mean_depdelay)) +
  geom_smooth(na.rm = TRUE) + 
  geom_point(aes(colour = mean_precip,
                 size = mean_depdelay),
             show.legend = FALSE) +
  ylab("Mean Departure Delay") +
  xlab("Mean Precipatation") +
  labs(title = "Change in average delay time according to change in average precipatation")

# Other Implementations ---------------------------------------------------
# base::merge() can perform all four types of mutating join:
# inner_join; merge(x, y)
# left_join; merge (x, y, all.x = TRUE)
# right_join; merge(x , y, all.y = TRUE)
# full_join; merge(x, y, all.x = TRUE, all.y = TRUE)

#  dplyr however uses verbs that are more clearly able to convey the intent of your code


# Filtering Joins ---------------------------------------------------------
# Filtering joins match observations in the same way as mutating joins, but affect the observations, not
# variables.  There are two types:
semi_join(x, y) # Keeps all observations in x that have a match in y
anti_join(x, y) # drops all observations in x that have a match in y

# Semi-joins are useful for matching filtered summary tables back to the original rows.  For example,
# imagine you've found the top-10 most popular destinations:
top_dest <- flights %>% 
  count(dest, sort = TRUE) %>% 
  head(10)
top_dest
# Now you want to find each flight that went to one of those destinations.  You could construct a filter
# yourself:
flights %>% 
  filter(dest %in% top_dest$dest)
# However, this is difficult to extend to multiple variables.  Instead you can use a semi-join, which
# connects the two tables like a mutating join, but instead of adding new columns, only keeps the rows in x
# that have a match in y:
flights %>% 
  semi_join(top_dest)
# In contrast, anti-joins are useful for diagnosing join mismatches.
flights %>%
  anti_join(planes, by = "tailnum") %>% 
  count(tailnum, sort = TRUE)
# What accounts for these missing values?
flights %>%
  anti_join(planes, by = "tailnum") %>% 
  count(carrier, sort = TRUE)


# Join Problems -----------------------------------------------------------
# There are a few things that you should do with your own data to make things go smoothly:
#1. Start by identifying the variables that form the primary key in each table.  You should usually do this
#   based on your understanding of the data, not empirically by looking for a combination of variables that
#   give a unique identifier.  If you just look for variables without thinking about what they mean, you 
#   might get (un)lucky and find a combination that's unqiue in your current data by the relationship
#   might not be true in general.  For example, the altitude and longitude uniquely identify each airport,
#   but they are not good identifiers!
airports %>% 
  count(alt, lon) %>% 
  filter(n > 1)

#2. Check that none of the variables in the primary key are missing.  If a value is missing then it can't
#   identify an observation!

#3. Check that your foreign keys match primary keys in another tables.  The best way to do this is with
#   anti_join().  It's common for keys not to match because of data entry errors.  Fixing these is often
#   a lot of work.

#   If you do have missing keys, you'll need to be thoughtful about your use of inner versus outer joins,
#   carefully considering whether or not you want to drop rows that don't have a match.


# Set Operations ----------------------------------------------------------
# Final type of two-table verb are the set operations.  These are occasionally useful when you want to break
# a single complex filter into simpler pieces.  All these operations work with a complete row, comparing the
# values of every variable.  These expect the x and y inputs to have the same variables, and treat the 
# observation like sets:

# intersect(x, y)
#   Return only the observations in both x and y
# union(x, y)
#   Return unique observations in x and y
# setdiff(x, y)
#   Return observations in x, but not in y

# Given this simple data:
df1 <- tribble(
  ~x, ~y,
  1, 1,
  2, 1
)
df2 <- tribble(
  ~x, ~y,
  1, 1,
  1, 2
)
# The four possibilities are:
intersect(df1, df2)

union(df1, df2)
#Note the 3 rows, not 4

setdiff(df1, df2)
setdiff(df2, df1)


# ============================================================================================================
# Strings with stringr: Chapter 11 ----------------------------------------
# ============================================================================================================

# Regular expressions or regexps for short, are a concise language for describing patterns in strings.
library(tidyverse)
library(stringr)


# String Basics -----------------------------------------------------------
string1 <- "This is a string"
string2 <- 'To put a "quote" inside a string, use single quotes'

# To include a literal single or double quote in a string you can use \ to 'escape' it:
double_quote <- "\"" # or '"'
single_quote <- '\'' # or "'"
# That means if you want to include a literal backslash, you'll need to double it up: "\\"
# Beware that the printed representation of a string is not the same as the string itself, because the 
# printed representation shows the escapes.  To see the raw contents of the string, use writeLines():
x <- c("\"", "\\")
x
writeLines(x)

# Other special characters:
#   "\n" is used for a newline
#   "\t" is for tab
# To see a complete list, type the command ?'"' or ?"'"
#   There are other characters for writing nonenlgish charcaters that work on all platforms:
x <- "\u00b5"
x



# String Length -----------------------------------------------------------
# str_length() tells you the number of characters in a string


# Combining Strings -------------------------------------------------------
#To combine two or more strings, use str_c():
str_c("x", "y")
str_c("x", "y", "z")

# To print missing values as NA, use:
x <- c("abc", NA)
str_c("|-", x, "-|")
str_c("|-", str_replace_na(x), "-|")

# str_c is vectorised, and it automatically recycles shorter vectors to the same length as the longest:
str_c("prefix", c("a", "b", "c"), "-suffix")

# Objects with length 0 are silently dropped.  This is particularly useful in conjunction with if:
name <- "Josh"
time_of_the_day <- "evening"
birthday <- FALSE

str_c(
  "Good ", time_of_the_day, " ", name,
  if (birthday) " and HAPPY BIRTHDAY",
  "."
)

# To collapse a vector of strings into a single string, use collapse:
str_c(c("x", "y", "z"), collapse = ", ")



# Subsetting Strings ------------------------------------------------------
# str_sub() extracts parts of a string.  str_sub() takes start and end arguments that give the (inclusive)
# position of the substring:
x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)

# negative numbers count backwards from end
str_sub(x, -3, -1)

# You can use it to modify strings:
str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))
x

# Note the use of a locale argument to set the language type, e.g. "en" for english 


# Basic Matches -----------------------------------------------------------
# The simplest patterns match exact strings:
x <- c("apple", "banana", "pear")
str_view(x, "an")

# The next step in complexity is ., which matches any character (except a newline):
str_view(x, ".a.")

# regexps use the backslash, \, to escape special behaviour.
# To create the regular expression, we need \\
dot <- "\\."
writeLines(dot)
# And this tells R to look for an explicit .
str_view(c("abc", "a.c", "bef"), "a\\.c")
# For a literal \, you need to escape it, just like with . , therefore you use \\\\:
x <- "a\\b"
writeLines(x)
str_view(x, "\\\\")


# Anchors -----------------------------------------------------------------

# use ^ to match the start of the string
# use $ to match the end of the string

x <- c("apple", "banana", "pear")
str_view(x, "^a")

str_view(x, "a$")

# Therefore, to force a regular expression to only match a complete string, anchor it with both ^ and $:
x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")
str_view(x, "^apple$")


str_view(stringr::words, "^y")
str_view(stringr::words, "x$")
str_view(stringr::words, "^...$", match = TRUE)
str_view(stringr::words, "^.......+", match = TRUE)



# Detect Matches ----------------------------------------------------------
# To determine if a character vector matches a pattern, use str_detect().  It returns a logical vector the
# same length as the input:
x <- c("apple", "banana", "pear")
str_detect(x, "e")

# Note that when you use a logical vector in a numeric context, FALSE becomes 0 and TRUE becomes 1.  That
# makes sum() and mean() useful if you want to answer questions about matches across a larger vector:

# E.g.
# How many common words start with t?
sum(str_detect(words, "^t"))
# What proportion of common words end with a vowel?
mean(str_detect(words, "[aeiou]$"))

# When you have complex logical conditions it's often easier to combine multiple str_detect() calls with 
# logical operators, rather than trying to create a single regular expression.  For example, here are two
# ways to find all words that don't contain any vowels:

# Find all words containing at least one vowel, and negate
no_vowels_1 <- !str_detect(words, "[aeiou]")
# Find all words consisting only of consonants (non-vowels)
no_vowels_2 <- str_detect(words, "^[^aeiou]+$")
identical(no_vowels_1, no_vowels_2)
# If your regexp gets overly complicated, try breaking it up into smaller pieces, giving each piece a name,
# and then combining the pieces with logical operations.

# A common use of str_detect() is to select the elements that match a pattern.  You can do this with logical
# subsetting, or the convienient str_subset() wrapper:
words[str_detect(words, "x$")]
str_subset(words, "x$")

# Typically however, your strings will be one column of a data frame, and you'll want to use filter()
# instead:
df <- tibble(
  word = words,
  i = seq_along(word)
)
df %>% 
  filter(str_detect(words, "x$"))

# A variation of str_detect() is str_count(): rather than a simple yes or no, it tells you how many matches
# there are in a string:
x <- c("apple", "banana", "oear")
str_count(x, "a")

# On average, how mnay vowels per word?
mean(str_count(words, "[aeiou]"))

# It's natural to use str_count() with mutate():
df %>% 
  mutate(
    vowels = str_count(word, "[aeiou]"),
    consonants = str_count(word, "[^aeiou]")
  )


# Extract Matches ---------------------------------------------------------
# To extract the actual text of a match, use str_extract().  
length(sentences)
head(sentences)
# Imagine we want to find all sentences that contain a colour.  We first create a vector of colour names,
# and then turn it into a single regular expression:
colours <- c(
  "red", "orange", "yellow", "green", "blue", "purple"
)
colour_match <- str_c(colours, collapse = "|")
colour_match
# Now we can select the sentences that contain a colour, and then extract the colour to figure out which one
# it is:
has_colour <- str_subset(sentences, colour_match)
matches <- str_extract(has_colour, colour_match)
head(matches)
# Note that str_extract() only extracts the first match.
more <- sentences[str_count(sentences, colour_match) > 1]
str_view_all(more, colour_match)
str_extract(more, colour_match)
# This is a common pattern for stringr functions, because working with a single match allows you to use
# simpler data structures.  To get all matches, use str_extract_all().  it returns a list:
str_extract_all(more, colour_match)
# If you use simplify = TRUE, str_extract_all() will return a matrix with short matches expanded to the same
# length as the longest:
str_extract_all(more, colour_match, simplify = TRUE)
x <- c("a", "a b", "a b c")
str_extract_all(x, "[a-z]", simplify = TRUE)

first_word <- str_extract(sentences, "^[A-Za-z]+")
first_word

ending_ing <- str_extract(sentences, "[A-Za-z]+ing")


# Grouped Matches ---------------------------------------------------------
# Imagine you want to extract nouns from a sentence.  As a heuristic, we'll look at any word that comes after
# "a" or "the".  Defining a "word" in a regular expression is tricky, therefore using a sequence of at least
# one character that isn't a space is necessary:
noun <- "(a|the) ([^ ]+)"
has_noun <- sentences %>% 
  str_subset(noun) %>% 
  head(10)
has_noun %>% 
  str_extract(noun)

# str_extract() gives the complete match; str_match() gives each individual componenent.  Instead of a 
# character vector, it returns a matrix, with one column for the complete match followed by one column
# for each group:
has_noun %>% 
  str_match(noun)
# Note that this heuristic for detecting nouns is poor, and also picks up adjectives like smooth and
# parked.

# If your data is in a tibble, it's often easier to use tidyr::extract().  It works like str_match() but
# requires you to name the matches, which are then placed in new columns:
tibble(sentence = sentences) %>% 
  tidyr::extract(
    sentence, c("article", "noun"), "(a|the) ([^ ]+)",
    remove = FALSE
  )
# Like str_extract(), if you want all matches for each string, you'll need str_match_all().

number <- "(one|two|three|four|five|six|seven|eight|nine) ([^ ]+)"
has_number <- sentences %>% 
  str_subset(number)
has_number %>% 
  str_extract(number)


# Replacing Matches -------------------------------------------------------
library(tidyverse)
library(stringr)

# str_replace() and str_replace_all() allow you to replace mathces with new strings.  The simplest use is to
# replace a pattern with a fixed string:
x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-")
str_replace_all(x, "[aeiou]", "-")

# With str_replace_all() you can perform multiple replacements by supplying a named vector:
x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", "3" = "three"))

# Instead of replacing with a fixed string, you can use backreferences to insert components of the match:
sentences %>% 
  head(5)
sentences %>% 
  str_replace("([^ ]+) ([^ ]+) ([^ ]+)", "\\1 \\3 \\2") %>% 
  head(5)


# Splitting ---------------------------------------------------------------
# str_split() is used to split a string up into pieces:
sentences %>% 
  head(5) %>% 
  str_split(" ")
# Because each component might contain a different number of pieces, this returns a list.  If you're working
# with a length-1 vector, the easiest thing is just to extract the first element of the list:
"a|b|c|d" %>% 
  str_split("\\|") %>% 
  .[[1]]
# Otherwise, liek other stringr functions that return a list, you can use simplify = TRUE to return a matrix:
sentences %>% 
  head(5) %>%
  str_split(" ", simplify = TRUE)
# You can also request a maximum number of pieces:
fields <- c("Name: Josh", "Country: ZAR", "Age: 25")
fields %>% 
  str_split(": ", n = 2, simplify = TRUE)
# Instead of splitting up strings by patterns, you can also split up by character, line, sentence, and word
# boundary()s:
x <- "This is a sentence.  This is another sentence."
str_view_all(x, boundary("word"))

str_split(x, " ")[[1]]
str_split(x, boundary("word"))[[1]]


# Other Types of Pattern --------------------------------------------------
# When you use a pattern that's a string, it's automatically wrapped into a call to regex():

# The regular call:
str_view(fruit, "nana")
# Is shorthand for:
str_view(fruit, regex("nana"))
# Therefore, you can control other arguments of regex() to control details of the match:
# ignore_case = TRUE allows characters to match either their uppercase or lowercase forms.  This always uses
# the current locale:
bananas <- c("banana", "Banana", "BANANA")
str_view(bananas, "banana")
str_view(bananas, regex("banana", ignore_case = TRUE))

# multiline = TRUE allows ^ and $ to match the start and end of each line rather than the start and end of
# each complete string:
x <- "Line 1\nLine 2\nLine 3"
str_extract_all(x, "^Line")[[1]]
str_extract_all(x, regex("^Line", multiline = TRUE))[[1]]

# comments = TRUE allows you to use comments and white space to make complex regular expression more
# understandable.  Spaces are ignored, as is everything after #.  To match a literal space, you'll need 
# to escape it: "\\ ".
phone <- regex("
               \\(?     # optional opening parens
               (\\d{3}) # area code
               [)- ]?   # optional closing parens, dashm or space
               (\\d{3}) # another three numbers
               [ -]?    # oiptional space or dash
               (\\d{3}) # three more numbers",
               comments = TRUE)
str_match("514-791-8141", phone)

# dotall = TRUE allows . to match everything, including \n.

# There are three other functions you can use instead of regex():

# fixed() matches exactly the specified sequence of bytes.  It ignores all special regular expressions and
# operates at a very low level.  This allows you to avoid complex escaping and can be much fatser than
# regular expressions.


# Other Uses of Regular Expressions ---------------------------------------

# apropos() searches all objects available from the global environment.  This is useful when you can't 
# remember the name of the function:
apropos("replace")

# dir() lists all the files in the directory.  The pattern = argument takes a regular expression and only 
# returns filenames that match the pattern.  For example, you can find all the R Markdown files in the
# current directly with:
head(dir(pattern = "\\.Rmd$"))


# Stringi -----------------------------------------------------------------
# Stringi is the comphrehensive advanced package of stringr.  If you ever struggle to do anythign with
# stringr, take a look at stringi.

# ============================================================================================================
# Factors with forcats: Chapter 12 ----------------------------------------
# ============================================================================================================

library(tidyverse)
library(forcats)
# forcats provides tools for dealing with categorical variables


# Creating Factors --------------------------------------------------------
# Imagine you have a variable that records month:
x1 <- c("Dec", "Apr", "Jan", "Mar")
# Using a string to record this variable has two problems:
# 1.  There are only twelve possible months, and there's nothing saving you from typos:
x2 <- c("Dec", "Apr", "Jam", "Mar")
# 2.  It doesn't sort in a useful way:
sort(x1)

# You can fix both of these problems with a factor.  To create a factor you must start by creating a list of
# valid levels:
month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)
# Now you can create a factor:
y1 <- factor(x1, levels = month_levels)
y1
sort(y1)

# And any values not in the set will be silently converted to NA:
y2 <- factor(x2, levels = month_levels)
y2

# If you want an error warning, you can use readr::parse_factor():
y2 <- parse_factor(x2, levels = month_levels)

# If you omit the levels, they'll be taken from the data in aplphabetical order:
factor(x1)

# Sometimes you'd prefer that the order of the levels match the order of the first appearance in the data.
# You can do that when creating the factor by setting levels to unique(x), or after the fact, with
# fct_inorder():
f1 <- factor(x1, levels = unique(x1))
f1
f2 <- x1 %>% 
  factor() %>% 
  fct_inorder()
f2

# If you ever need to access the set of valid levels directly, you can do so with levels():
levels(f2)


# General Social Survey ---------------------------------------------------
gss_cat

# When factors are stored in a tibble, you can't see their levels so easily.  One way to see them is with
# count():
gss_cat %>% 
  count(race)
# Or with a bar chart:
ggplot(gss_cat, aes(race)) +
  ylab("Number of individuals") +
  xlab("Race") +
  geom_bar(aes(fill = race), show.legend = FALSE)

# By default, ggplot2 will drop levels that don't have any values.  You can force them to display with:
ggplot(gss_cat, aes(race)) +
  ylab("Number of individuals") +
  xlab("Race") +
  geom_bar(aes(fill = race), show.legend = FALSE) +
  scale_x_discrete(drop = FALSE)
# These levels represent valid values that simply don't occur in this dataset.  Unfortunately, dplyr doesn't
# have a drop option, but it will in the future.

# When working with factors, the two most common operations are changing the order of the levels, and
# changing the values of the levels.

# Exercise:
ggplot(gss_cat, aes(rincome)) +
  ggtitle("Distribution of Income categories") +
  ylab("Number of reported income categories") +
  xlab("Income categories") +
  geom_bar(aes(fill = race), show.legend = FALSE) +
  scale_x_discrete(drop = FALSE) +
  coord_flip()
  

# Modifying Factor Order --------------------------------------------------
# It's often useful to change the order of the factor levels in a visualisation.  For example, imagine you 
# want to explore the average number of hours spend watching TV per day across religions:
relig <- gss_cat %>% 
  group_by(relig) %>% 
  summarise(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )
ggplot(relig, aes(tvhours, relig)) +
  geom_point()

# It is difficult to interpret this plot becayse there's no overall pattern.  We can improve it by reordering
# the levels of relig using fct_reorder().  fct_reorder() takes three arguments:

# f, the factor whose levels you want to modify.
# x, a numeric vector that you want to use to reorder the levels.
# Optionally, fun, a function that's used if there are multiple values of x for each value of f.  The default
# value is median.
ggplot(relig, aes(tvhours, fct_reorder(relig, tvhours))) +
  geom_point()
# Reordering religion makes it much easier to see that people in the "Don't Know" category watch much more
# TV and Hinduism and other Eastern religions watch much less.

# As you start making more complicated transformations, it is more efficient to move them out of aes() and
# into a seperate mutate() step.  For example, you could rewrite the preceding plot as:
relig %>% 
  mutate(relig = fct_reorder(relig, tvhours)) %>% 
  ggplot(aes(tvhours, relig)) +
  geom_point()
# Create a similar plot looking at how average age varies across reported income level:
rincome <- gss_cat %>% 
  group_by(rincome) %>% 
  summarise(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )
ggplot(rincome, aes(age, fct_reorder(rincome, age))) +
  geom_point()
# Note! Here, arbitrarily reordering the levels isn't a good idea! That's because rincome already has a
# principled order that we shouldn't mess with.  Reserve fct_reorder() for factors whose levels are 
# arbitrarily ordered.

# However, it does make sense to pull "Not applicable" to the front with the other special levels.  You can
# use fct_relevel().  It takes a factor, f, and then any number of levels that you want to move to the front
# of the line:
ggplot(rincome, aes(age, fct_relevel(rincome, "Not applicable"))) +
  geom_point()

# Another tyoe of reordering is useful when you are colouring the lines on a plot.  fct_reorder2() reorders
# the factor by the y values associated with the largest x values.  This makes the plot easier to read 
# because the line colours line up with the legend:
by_age <- gss_cat %>%
  filter(!is.na(age)) %>%
  group_by(age, marital) %>%
  count() %>%
  mutate(prop = n() / sum(n))
ggplot(by_age, aes(age, prop, colour = marital)) +
  geom_line()

ggplot(by_age, aes(age, prop, colour = fct_reorder2(marital, age, prop))) +
  geom_line() +
  labs(colour = "marital")

# Finally, for bar plots, you can use fct_infreq() to order levels in increasing frequency: this is the
# simplest type of reordering because it doesn't need any extra variables.  You may want to combine it with
# fct_rev():
gss_cat %>% 
  mutate(marital = marital %>% fct_infreq() %>% fct_rev()) %>% 
  ggplot(aes(marital)) +
  geom_bar(aes(fill = marital), show.legend = FALSE) +
  coord_flip()+
  ylab("Category counts") +
  xlab("Marital status")

# Modifying Factor Levels -------------------------------------------------
# More powerful than changing the orders of the levels is changing their values.  This allows you to clarify
# labels for publication, and collapse levels for high-level displays.  The most general and powerful tool
# is fct_recode().  It allows you to recode, or change, the value of each level.  For example, take
# gss_cat$partyid:
gss_cat %>% 
  count(partyid)
# The levels are terse and inconsistent.  Tweak them to be longer and use a parallel construction:
gss_cat %>% 
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong" = "Strong republican",
                              "Republican, weak" = "Not str republican", 
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak" = "Not str democrat",
                              "Democrat, strong" = "Strong democrat"
                              )) %>%
  count(partyid)

# fct_recode() will leave levels that aren't explicitly mentioned as is, and will warn you if you
# accidentally refer to a level that doesn't exist.  To combine groups, you can assign multiple old levels
# to the same new level:
gss_cat %>% 
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong" = "Strong republican",
                              "Republican, weak" = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak" = "Not str democrat",
                              "Democrat, strong" = "Strong democrat",
                              "Other" = "No answer",
                              "Other" = "Don't know",
                              "Other" = "Other party"
                              )) %>% 
  count(partyid)
# Use this technique with care: if you group together categories that are truly different you will end up 
# with misleading results.

# If you want to collapse a lot of levels, fct_collapse() is a useful variant of fct_recode().  For each new
# variable, you can provide a vector of old levels:
gss_cat %>% 
  mutate(partyid = fct_collapse(partyid,
                                other = c("No answer", "Don't know", "Other party"),
                                rep = c("Strong republican", "Not str republican"),
                                ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                dem = c("Not str democrat", "Strong democrat")
                                )) %>% 
  count(partyid)

# Sometimes you just want to lump together all the small groups to make a plot or table simpler.  That's the
# job of fct_lump():
gss_cat %>% 
  mutate(relig = fct_lump(relig)) %>% 
  count(relig)
# The default behaviour is to progressively lump together the smallest groups, ensuring that the aggregate is
# still the smallest group.  In this case it's not very helpful: it is true that the majority of Americans
# in this survey are Protestnat, but we've probably overcollapsed.  Instead, we can use the n parameter to
# specify how many groups (excluding other) we want to keep:
gss_cat %>% 
  mutate(relig = fct_lump(relig, n = 10)) %>% 
  count(relig, sort = TRUE)

partyid_over_time <- gss_cat %>% 
  group_by(year) %>% 
  mutate(partyid = fct_collapse(partyid,
                                other = c("No answer", "Don't know", "Other party"),
                                rep = c("Strong republican", "Not str republican"),
                                ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                dem = c("Not str democrat", "Strong democrat")
                                )) %>% 
  count(partyid)

ggplot(partyid_over_time, aes(year, n)) +
  geom_bar(aes(fill = partyid), stat = "identity", position = "fill") +
  ylab("Proportion of individuals identifying with the ... party bienially") +
  xlab("Year\nNote: each bar accounts for every bienial year")


# ============================================================================================================
# Dates and Times with lubridate: Chapter 13 ------------------------------
# ============================================================================================================

library(tidyverse)
library(lubridate)
library(nycflights13)
# Note that lubridate is not part of the core tidyverse package because you only need it when working with 
# dates.


# Creating Dates/Times ----------------------------------------------------
# A date: tibbles print this as <date>
# A time within a day: tibbles rpint this as <time>
# A date-time is a date plus a time: it uniquely identifies an instant in time (typically the nearest
# second).  Tibbles print this as <dttm> or called POSIXct but this isn't a very useful name.

# Note: if you need a native class for storing times you can use the hms package.

# You should always work with the simplest possible data type that works for your needs.  I.e. if you can
# use a date instead of a date-time, you should.  To get th eucrrent date or date-time():
today()
now()

# There are three ways that you are most likely to create a date/time; from:
# a string
# individual date-time components
# existing date/time objects


# From Strings ------------------------------------------------------------
# As already mentioned, one can parse-strings into date-times.  lubridate has easier helpers:
ymd("2017-01-31")
mdy("January 31st, 2017")
dmy("31-Jan-2017")
# These functions also take unquoted functions:
ymd(20170131)
# ymd() and derivatives create dates.  To create a date-time, add an underscore and one or more of "h", "m",
# and "s" to the name of the parsing function:
ymd_hms("2017-01-31 20:11:59")
mdy_hm("01/31/2017 08:01")
# You can also force the creation of a date_time from a date by supplying a time zone:
ymd(20170131, tz = "GMT")


# From Individual Components ----------------------------------------------
# Sometimes you'll have individual components of the date-time spread across multiple columns.  This is what
# occurs in the flights data:
flights %>% 
  select(year, month, day, hour, minute)
# To create a date/time from this sort of input, use make_date() for dates, or make_datetime() for
# date-times:
flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(
    departure = make_datetime(year, month, day, hour, minute)
  )

# Now do the same thing for each of the four time columns in flights.  Because the times are represented in
# an odd format, use modulus arithmetic to pull out the hour and minute components:
make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
}

flights_dt <- flights %>% 
  filter(!is.na(dep_time), !is.na(arr_time)) %>% 
  mutate(
    dep_time = make_datetime_100(year, month, day, dep_time),
    arr_time = make_datetime_100(year, month, day, arr_time),
    sched_dep_time = make_datetime_100(
      year, month, day, sched_dep_time
    ),
    sched_arr_time = make_datetime_100(
      year, month, day, sched_arr_time
      )
  ) %>% 
  select(origin, dest, ends_with("delay"), ends_with("time"))

flights_dt
# With this data, you can now visualise the distribution of departure times across the year:
flights_dt %>% 
  ggplot(aes(dep_time)) +
  geom_freqpoly(binwidth =86400) #  86400 seconds = 1 day
# or within a single day:
flights_dt %>% 
  filter(dep_time < ymd(20130102)) %>% 
  ggplot(aes(dep_time)) +
  geom_freqpoly(binwidth = 600) # 600 seconds = 10 minutes

# Note that when you use date-times in a numeric context (like in a histogram), 1 means 1 second, so a
# binwidth of 86400 means on day.  For dates, 1 means 1 day.



# ============================================================================================================
# Pipes with magrittr -----------------------------------------------------
# ============================================================================================================

library(dplyr)
library(magrittr)

# The point of pipe is to enable you to write code in a more comprehesible way.  To see why pipe is useful,
# let's explore a number of ways of writing the same code that tells a story:

#   Little bunny Foo Foo
#   Went hopping through the forest
#   Scooping up the field mice
#   And bopping them on the head

# Start by defining an object to represent little bunny Foo Foo:
foo_foo <- little_bunny()

# Then you can use a function for each key verb: hop(), scoop(), and bop().  Using this object and these
# verbs, there are (at least) four ways we could retell the story in code:
  # Save each intermediate step as a new object
  # Overwrite the original object many times
  # Compose functions
  # Use the pipe

# Intermediate Steps ------------------------------------------------------

# The simplest approach is to save each step as a new object:
foo_foo_1 <- hop(foo_foo, through = forest)
foo_foo_2 <- scoop(foo_foo_1, up = field_mice)
foo_foo_3 <- bop(foo_foo_2, on = head)
# The main downside of this form is that it forces you to name each intermediate element.  If there are many
# natural names, this is a good idea, and you should do it.  But a lot of the time, like in this example, 
# there aren't natural names, and you add numeric suffixes to make the names unique.  This leads to two 
# problems:

# The code is cluttered with unimportant names
# You have to carefully uncrement the suffix on each line

# Often you will invariably use the wrong number on one line and then spend 10 minutes scratching your head 
# and trying to figure out what went wrong with the code.


# Overwrite the Original --------------------------------------------------

# Instead of creating intermediate objects at each step, we could over-write the original object:
foo_foo <- hop(foo_foo, through = forest)
foo_foo <- scoop(foo_foo, up = field_mice)
foo_foo <- bop(foo_foo, on = head)
# This is less typing (and less thinking), so you're less likely to make mistakes.  However, there are two
# problems:

# Debugging is painful.  If you make a mistake you'll need to re-run the complete pipeline from the 
# beginning.
# The repitition of the object being transformed (like writing foo_foo six times), obscures what's changing
# on each line.


# Function Composition ----------------------------------------------------

# Another approach is to abandon assignment and just string the function calls together:
bop(
  scoop(
    hop(foo_foo, through = forest),
    up = field_mice
  ),
  on = head
)
# Here the disadvantage is that you have to read from inside-out, from right-to-left, and that the arguments
# end up spread far apart.  In short, it is hard for a human to consume.


# Use the Pipe ------------------------------------------------------------

# Use the pipe!
foo_foo %>% 
  hop(through = forest) %>% 
  scoop(up = field_mice) %>% 
  bop(on = head)

# The pipe worls by making a 'lexical transformation'; behind the scenes magrittr reassembles the code in the
# pipe to a form that works by overwriting an intermediate object.  When you run a pipe like the above, 
# magrittr does something like this:
my_pipe <- function(.) {
  . <- hop(., through = forest)
  . <- scoop(., up = field_mice)
  bop(., on = head)
}
my_pipe(foo_foo)
# This means that the pipe won't work for two classes of functions:

  # Functions that use the current environment.  For example, assign() will create a new variable with the
  # current environment:
assign("x", 10)
x

"x" %>% assign(100)
x
# The use of assign with pipe does not work because it assigns it to a temporary environment used by %>%.
# If you do want to use assign() with  pipe, you must be explicit about the environment:
env <- environment() 
"x" %>% assign(100, envir = env)
x
# Other functions with this problem include get() and load()

  # Functions that use lazy evaluation.  In R, function arguments are only computed when the function uses
  # them, not prior to calling the function.  The pipe computes each element in turn, so you can't
  # rely on this behaviour.

# One place that this is a problem is tryCatch(), which let's you capture and handle errors:
tryCatch(stop("!"), error = function(e) "An error")

stop("!") %>% 
  tryCatch(error = function(e) "An error")
# There are a relatively wide class of functions with this behaviour, including try(), SuppressMessages(),
# and suppressWarnings() in base R.


# When Not to Use the Pipe ------------------------------------------------

# The pipe is a powerful tool, but it is not the only tool at your disposal, and it doesn't solve every
# problem! Pipes are most useful for rewriting a fairly short linear sequence of operations.  You should
# however, reach for another tool when:

#   Your pipes are longer than ~ 10 steps.  In such cases, create intermediate objects with meaningful
#   names.  That will make debugging easier, because you can more easily check the intermediate results,
#   and it makes it easier to understand the code, because the variable names can help communicate the
#   content.

#   You have multiple inputs or outputs.  If there isn't one primary object being transformed, but two or
#   more objects being combined together, don't use pipe!

#   You are starting to think about a directed graph with a complex dependency structure.  Pipes are
#   fundamentally linear and expressing complex relationships with them will typically yield confusing
#   code.


# Other Tools from magrittr -----------------------------------------------

# All the packages in the tidyverse automatically make %>% available for you, so you don't normally load
# magrittr explicitly.  However, there are some other useful tools inside magrittr that you can try out:

#   When working with more complex pipes, it's sometimes useful to call a function for its side effects.
#   Maybe you want to print out the current object, or plot it, or save it to disk.  Many times, such
#   functions don't return anything, effectively terminating the pipe.

#   To work around this problem, you can use the 'tee' pipe. %T>% works like %>% except that it returns the
#   lefthand side instead of the righthand side.  It's called the 'tee' because it's like a literal T-shaped
#   pipe:
rnorm(100) %>% 
  matrix(ncol = 2) %>% 
  plot() %>% 
  str()

rnorm(100) %>% 
  matrix(ncol = 2) %T>% 
  plot() %>% 
  str()

# If you're working with functions that don't have a data frame based API (i.e. you pass them individual
# vectors, not a data frame and expressions to be evaluated in context of that data frame), you might find
# the %$% operator useful.  It 'explodes' out the variables in a data frame so that you can refer to them 
# explicitly.  This is useful when working with many functions in base R:
mtcars %$%  
  cor(disp, mpg)


# ============================================================================================================
# Chapter 15: Functions ---------------------------------------------------
# ============================================================================================================

# Intro -------------------------------------------------------------------

# Functions allow you to automate common tasks in a more powerful and general way than copying and pasting.
# Writing a function has three big advantages over using copy-and-paste:

#   You can give a function an evocative name that makes your code easuer to understand.
#   As requirements change, you only need to update code in one place, instead of many.
#   You eliminate the chance of making incidental mistakes when you copy and paste (i.e. updating a variable
#   name in one place, but not in another).

# Writing good functions is a lifetime journey, you will constantly learn and improve technqiues, knowledge,
# and better ways of approaching problems.  


# When Should You Write a Function? ---------------------------------------

# You should consider writing a function whenever you've copied and pasted a block of code more than twice 
# (i.e. you now have three copies of the same code).  For example, take a look at this code; what does it do?
df <- tibble::tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

df$a <- (df$a - min(df$a, na.rm = TRUE)) / 
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))
df$b <- (df$b - min(df$b, na.rm = TRUE)) / 
  (max(df$b, na.rm = TRUE) - min(df$a, na.rm = TRUE))
df$c <- (df$c - min(df$c, na.rm = TRUE)) / 
  (max(df$c, na.rm = TRUE) - min(df$c, na.rm = TRUE))
df$d <- (df$d - min(df$d, na.rm = TRUE)) / 
  (max(df$d, na.rm = TRUE) - min(df$d, na.rm = TRUE))
# It rescales each column to have a range of 0 to 1.  But, mistakes often happen in lengthy code, as in the
# example above!  Therefore, extracting repeated code out into a function is a good idea because it prevents
# you from making mistakes.

# To write a function you first need to analuse the code.  How many inputs does it have?
df$a <- (df$a - min(df$a, na.rm = TRUE)) / 
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))
# This code only has one input: df$a.  To make the inputs more clear, it's a good idea to rewrite the code
# using temporary variables with general names.  Here this code only requires a single numeric vector, so
# let's call it 'x':
x <- df$a
(x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))

# There is some duplication in this code.  We're computing the range of the data three times, but it makes
# sense to do it in one step:
rng <- range(x, na.rm = TRUE)
(x - rng[1]) / (rng[2] - rng[1])

# Pulling out intermediate calculations into named variables us a good practice because it makes it more 
# clear what the code is doing.  Now that you have simplified the code, and checked that it still works, you
# can turn it into a function:
rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}
rescale01(c(0, 5, 10))

# There are three key steps to creating a new function:

  # You need to pick a name for the function; above we used the name rescale01 because the functions rescales
  # a vector to lie between 0 and 1.

  # You list the inputs, or called arguments, to the function inside function().  Here we just have one
  # argument.  If we had more the call would look like function(x, y, z).

  # You place the code you have developed in the body of the function, a{ block that immediately follows
  # function(...) }

# Note the overall process: the function is only made after you have figured out how to make it work with a
# simple input.  It's easier to start with working code and turn it into a function; it's harder to create
# a function and then try to make it work.

# At this point it's a good idea to check your function with a few different inputs:
rescale01(c(-10, 0, 10))
rescale01(c(1, 2, 3, NA, 5))

    # Learn more about automating this testing procedure; R Packages O'Reily textbook...

# We can simplify the original example now that we have a function:
df$a <- rescale01(df$a)
df$b <- rescale01(df$b)
df$c <- rescale01(df$c)
df$d <- rescale01(df$d)
# Compared to the original, this code is easier to understand and we've elimated one class of copy-and-paste
# errors.  There is still duplication, which we will learn to eliminate at a later stage...

# Another advantage of functions is that if our requirements change, we only need to make the change in one
# place.  For example, we might discover that some of our variables include infinte values, and rescale01()
# fails:
x <- c(1:10, Inf)
rescale01(x)
# Because we've extracted the code into a function, we only need to make the fix in one place:
rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE, finite = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}
rescale01(x)
# This is an important part of the "do not repeat yourself" (or DRY) principle.  The more repitition you have
# in your code, the more places you need to remember to update when things change; therefore, you are more
# likely to create bugs over time!


# Exercise ----------------------------------------------------------------

# Let's write functions to compute the variance and skew of a numeric vector:

herbivores_data <- readr::read_csv("/Users/joshuamusson/Desktop/Data_Analytics/Rstudio/r4ds/seed_root_herbivores.csv")

# We can already compute mean of height:
mean(herbivores_data$Height)
# And variance:
var(herbivores_data$Height)
# And the sample size:
length(herbivores_data$Height)
# so it seems easy to compute the standard error:
sqrt(var(herbivores_data$Height) / length(herbivores_data$Height))
# notice how data$Height is repeated there — not desirable.

# Suppose we now want the standard error of the dry weight too:
sqrt(var(herbivores_data$Weight) / length(herbivores_data$Weight))

# Look more carefully at the two statements and see the similarity in form, and what is changing between 
# them. This pattern is the key to writing functions.
#   sqrt(var(herbivores_data$Height) / length(herbivores_data$Height))
#   sqrt(var(herbivores_data$Weight) / length(herbivores_data$Weight))

# Here is the syntax for defining a function, used to make a standard error function:
#   We can do this by assuming the Central Limit Theorem; our data therefore has a normal distribution; where
#   the mean of the sample is equal to the mean of the population, and the sd of the sample is can be
#   calculated because it is equal to the sd of the population divided by the sqrt of the sample size n.
#   Standard Error (SE) measures how far the sample mean of the data is likely to be from the true population 
#   mean
hist(herbivores_data$Height)

standard_error <- function(x) {
  sqrt(var(x) / length(x))
}
# The result of the last line is “returned” from the function.
# We can call it like this:
standard_error(herbivores_data$Height)
standard_error(herbivores_data$Weight)

# Note that x has a special meaning within the curly braces. If we do this:
x <- 1:100
standard_error(herbivores_data$Height)
# we get the same answer. Because x appears in the “argument list”, it will be treated specially. Note also 
# that it is completely unrelated to the name of what is provided as value to the function.

# You can define variables within functions:
standard_error <- function(x) {
  v <- var(x)
  n <- length(x)
  sqrt(v / n)
}
# This can often help you structure your function and your thoughts.

# These are also treated specially — they do not affect the main workspace (the “global environment”) and 
# are destroyed when the function ends. If you had some value v in the global environment, it would be 
# ignored in this function as soon as the local v was defined, with the local definition used instead.

# We used the variance function above, but let’s rewrite it.  This case is more complicated, so we’ll do it 
# in pieces.

#   We’re going to use x for the argument, so name our first input data x so we can use it:
x <- herbivores_data$Height

# The first term is easy:
n <- length(x)
(1 / (n - 1))

# The second term is harder. We want the difference between all the x values and the mean:
m <- mean(x)
x - m

# Then we want to square those differences:
(x - m)^2

# and compute the sum:
round(sum((x - m)^2))

# Putting both halves together, the variance is:
(1 / (n - 1)) * sum((x - m)^2)
# Which agrees with R’s variance function:
var(x)

# The rm function cleans up:
rm(n, x, m)

# We can then define our function, using the pieces that we wrote above:
variance <- function(x) {
  # Define sample sample size:
  n <- length(x)
  # Define mean of variable:
  m <- mean(x)
  # Compute the variance:
  (sum((x - m)^2) / (n - 1))
}
# And test it:
variance(herbivores_data$Height)
var(herbivores_data$Height)

variance(herbivores_data$Weight)
var(herbivores_data$Weight)

# Exercise: define a function to compute skew -----------------------------

# Skewness is a measure of asymmetry of a probability distribution.  It can be defined as:
    # is a measure of the asymmetry of the probability distribution of a real-valued random variable about 
    # its mean. The skewness value can be positive or negative, or undefined.

# Here we will use the the kth central moment method of calculating skewness:
#   Here: Skewness is the ratio of (1) the third moment and (2) the second moment raised to the power of 3/2
#   (which is equal to the ratio of the third moment and standard deviation cubed) using the Maxell-Boltman
#   skewness distribution...

skewness <- function(maxwell) {
  n <- length(maxwell)
  v <- var(maxwell)
  m <- mean(maxwell)
  third.moment <- (1 / (n - 2)) * sum((maxwell - m)^3)
  third.moment / (var(maxwell)^(3/2))
}

skewness(herbivores_data$Height)
skewness(herbivores_data$Weight)


# Create a function that returns the number of positions that have an NA in two vectors of the same length:
both_na <- function(x, y) {
  sum(is.na(x) + is.na(y))
}

x <- c(1, 33, 2, 2, 5, NA, 2, 1, NA, 2, NA)
y <- c(1, NA, 2, 2, 5, NA, 2, 1, NA, NA, 2)

both_na(x, y)

# ============================================================================================================
# Functions Are for Humans and Computers ----------------------------------
# ============================================================================================================

# R doesn't care what a function is called, or what comments it contains, but these are important for human
# readers.  Therefore, there are several things to keep in mind.

# Ideally, the name of a function should be short, but clearly evokes what the function does.  It is however,
# better to be clear than short! Think autocomplete.

# Function names should preferably be verbs, and arguments should be nouns; nouns used as a function name
# are OK if the function computes a very well known noun (i.e. the mean), or is accessing some property of
# an object (i.e. coef()).  Never be afraid to rename a function if you think of a better name!

# If you have a family of functions that do similar things, make sure they have consitent names and 
# arguments.  Use a common prefix to indicate that they are connected.  

# Use comments to explain the 'why' of your code; avoid comments that explain the 'what' or the 'how'.  

# ============================================================================================================
# Conditional Execution ---------------------------------------------------
# ============================================================================================================

# An if statement allows you to conditionally execute code.  It looks like this:
if (condition) {
  # code executed when condition is TRUE
} else {
  # code executed when condition is FALSE
}

# Here is a simple function that uses an if statement.  The goal of this function is to return a logical 
# vector describing whether or not each element of a vector is named:
has_name <- function(x) {
  nms <- names(x)
  if (is.null(nms)) {
    rep(FALSE, length(x))
  } else {
    !is.na(nms) & nms != ""
  }
}
# This function takes advantage of the standard return rule: a function returns the last value that it
# computed.  Here that is either one of the two branches of the if statement.


# Conditions --------------------------------------------------------------

# The condition must evaluate to either TRUE or FALSE.  If it's a vector, you'll get a warning message; if
# it's an NA, you'll get an error.  Watch our for these messages in your own code, for example:
if (c(TRUE, FALSE)) {}
if (NA) {}

# You can use || (or) and && (and) to combine multiple logical expressions.  These operators are 'short-
# circuiting': as soon as || sees the first TRUE it returns TRUE without computing anything else.  As soon
# as && sees the first FALSE it returns FALSE.  You should never use | or & in an if statement: these are
# vectorised operations that apply to multiple values (that's why you use them in filter()).  If you do have
# a logical vector, you can use any() to collapse it to a single value.

# Be careful when testing for equality.  == is vectorised, which means that it's easy to get more than one
# output.  Either check the length is already 1, collapse with all() or any(), or use the nonvectorised
# identical().  indentical() is very strict: it always returns either a single TRUE or FALSE, and doesn't
# coerce types.  This means that you need to be careful when comparing integers and doubles:
identical(0L, 0)

# You also need to be wary of floating-point numbers:
x <- sqrt(2)^2
x
x == 2
x - 2
# Instead use dplyr::near() for comparisons.
dplyr::near(x, 2)

# And remember, x == NA doesn't do anything useful!


# Multiple Conditions -----------------------------------------------------

# You can chain multiple if statements together:
if (this) {
  # do that
} else if (that) {
  # do something else
} else {
  #
}

# But if you end up with a very long series of cahined if statements, you should consider rewriting.  One useful
# technique is the switch() function.  It allows you to evaluate selected code based on position or name:
function(x, y, op) {
  switch (op,
    plus = x + y,
    minus = x - y,
    times = x * y,
    divide = x / y,
    stop("Unknown op!")
  )
}

# Another useful function that can often eliminate long chains of if statements is cut().  It's used to
# discretise continuous variables (creates a range value that solves to a logical vector).


# Code Style --------------------------------------------------------------

# Both if and function should (almost) always be followed by squigly brackets ({}), and the contents should be
# indented by two spaces.  However it is OK to drop the curly braces for a short if statement that can fit
# on one line:
y <- c(21)
x <- if (y < 20) "Too low" else "Too high"
# However, this is recommended for very brief if statements.  Otherwise, the full form is easier to read:
if (y < 20) {
  x <- "Too low"
} else {
  x <- "Too high"
}
x

# Note: ifelse is a logical test; if statements are conditional statements.  Therefore, ifelse returns a value(s)
# whereas an if statement returns an operation accordint to a condition.

# Create a function that returns a greeting that is dependent on the time of day:
greeting <- function(time = lubridate::now()) {
  # Extract hour of day using hour() function;
  # generate logical test for extracted hour of day:
  hr <- lubridate::hour(time)
  # Conditional statements for time of day:
  if (hr < 12) {
    print("Good morning")
  } else if (hr < 17) {
    print("Good afternoon")
  } else {
    print("Good evening")
  }
}
# run function:
greeting()


# Create a fizzbuzz function; it takes a single number as an input.  If the input is divisible by three, it 
# returns 'fizz'.  If it's divisible by five it returns 'buzz'.  If it's divisible by three and five, it returns
# 'fizzbuzz'.
fizzbuzz <- function(x) {
  # Create modulus division:
  by_three <- x %% 3 == 0
  
  by_five <- x %% 5 == 0
  # Create conditional statements:
  # Here, the boolian && is used
  # as it is preferred in if
  # statements...
  if (by_three && by_five) {
    return("fizzbuzz")
  } else if (by_three) {
    return("fizz")
  } else if (by_five) {
    return("buzz")
  } else {
    return(x)
  }  
}
sapply(1:20, fizzbuzz)

# Use cut to simplify:
temp <- c(8, 30)

if (temp <= 0) {
  "freezing"
} else if (temp <= 10) {
  "cold"
} else if (temp <= 20) {
  "cool"
} else if (temp <= 30) {
  "warm"
} else {
  "hot"
}

cut(temp, breaks = seq(-10, 40, 10),
    # seq(from, to, by = 10...)
    labels = c("freezing", "cold", "cool", "warm", "hot"))

# What happens if you use switch() with numeric values?
x = 1
switch (x,
  1 = "No",
  2 = "Yes"
)
# Versus
switch (x,
  `1` = "No",
  `2` = "Yes"
)

# What does this switch() call do? What happens if x is "e"?
switch (x,
  a = ,
  b = "ab",
  c = ,
  d = "cd"
)
# If the value of EXPR is not a character string it is coerced to integer. BUT If EXPR evaluates to a character 
#string then that string is matched (exactly) to the names of the elements in .... If there is a match then that
# element is evaluated unless it is missing, in which case the next non-missing element is evaluated, so for 
# example switch("cc", a = 1, cc =, cd =, d = 2) evaluates to 2.
switch ("e",
        a = ,
        b = "ab",
        c = ,
        d = "cd",
        e =,
        f = "cc"
)


# Function Arguments ------------------------------------------------------

# Thge arguments to a function can fall into tso broad sets: one set supplies the data to compute on, and the 
# other supplies arguments that control the details of the computation.   For example:

  # In log(), the data is x, and the detail is the base of the logarithm. 

  # In mean(), the data is x, and the details are how much data to trim from the ends (trim) and how to handle
  # missing values (na.rm)

  # In t.test(), the data are x and y, and the details of the test are alternative, mu, paired, var, .equal, and
  # conf.level.

  # In str_c() you can supply any number of strings to ... , and the details of the concatenation are controlled
  # by sep and collapse.

# Generally, data arguments should come first.  Detail arguments should go on the end, and usually should have
# default values.  You can specify a default value in the same way you call a function with a named argument:

  # Compute confidence interval around mean using normal approximation:
  mean_ci <- function(x, conf = .95) {
    se <- sd(x) / sqrt(length(x ))
    alpha <- 1 - conf
    mean(x) + se * qnorm(c(alpha / 2, 1 - alpha / 2))
  }

x <- runif(100)
mean_ci(x)
mean_ci(x, conf = .99)
# The default value should almost always be the most common value.  The few exceptions to this rule have to do
# with safety.  For example, it makes sense for na.rm to default to FALSE because missing values are important.
# Even though na.rm = TRUE is what you usually put in your code, it's a bad idea to silently ignore missing 
# values by default.

# When you call a function, you typically omit the names of the data arguments, because they are used so commonly
# If you override the default value of a detail argiment, you should use the full name:

  # Good!
mean(1:10, na.rm = TRUE)

  # Bad!
mean(x = 1:10, , FALSE)
mean(, TRUE, x = c(1:10, NA))

# You can refer to an argument by its uniqiue prefix (e.g. mean(x, n = TRUE)), but this is generally best avoided
# given the possibilities for confusion.  


# Checking Values ---------------------------------------------------------

# It's often useful to make constraints explicit.  For example:
wt_mean <- function(x, w) {
  sum(x * w) / sum(x)
}
wt_var <- function(x, w) {
  mu <- wt_mean(x, w)
  sum(w * (x - mu)^2) / sum(w)
}
wt_sd <- function(x, w) {
  sqrt(wt_var(x, w))
}
# What happens if x and w are not the same length?
wt_mean(1:6, 1:3)
wt_var(1:6, 1:3)
wt_sd(1:6, 1:3)
# In this case, because of R's vector recycling rules, we don't get an error.  It is therefore good practice to
# check important preconditions in functions; when writing your own functuons you can throw an error using
# stop() if the preconditions are not true:
wt_mean <- function(x, w) {
  if (length(x) != length(w)) {
    stop("variables `x` and `w` must be of the same length", call. = FALSE)
  } 
  sum(w * x) / sum(x)
}
wt_mean(1:6, 1:3)
# However, doing this for every argument within a complicated function can be tedious.  For example, if you 
# added an na.rm argument to the previous function, it can be tedious.  

# A good trade-off is to use the stopifnot() function; it checks that each argument is TRUE, and produces a 
# generic error message if not:
wt_mean <- function(x, w, na.rm = FALSE) {
  stopifnot(is.logical(na.rm), length(na.rm) == 1)
  stopifnot(length(x) == length(w))
  
  if (na.rm) {
    miss <- is.na(x) | is.na(w)
    x <- x[!miss]
    w <- w[!miss]
  }
  sum(w * x) / sum(x)
}
wt_mean(1:6, 6:1, na.rm = "foo")
wt_mean(1:6, 1:3)


# Dot-Dot-Dot -------------------------------------------------------------

# Many functions in R take an arbitrary number of inputs:
sum(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
stringr::str_c("a", "b", "c", "d", "e", "f")
# How do these functions work? They rely on a special argument: ... (pronounced dot-dot-dot).  This special 
# argument captures anu number of arguments that aren't otherwise matched.

# The dot-dot-dot argument is useful because you can send those ... on to another function.  This is a iseful
# catch-all if your function primarily wraps another function.  For example, using ... with helper functions
# that wrap around str_c():
commas <- function(...) {
  stringr::str_c(..., collapse = ", ")
}
(letters[1:10])
commas(letters[1:10])

rule <- function(..., pad = "-") {
  title <- paste0(...)
  width <- getOption("width") - nchar(title) - 5
  cat(title, " ", stringr::str_dup(pad, width), "\n", sep = "")
}
rule("Important output")
# Here ... allows you to forward on any argument that I don't want to deal with to str_c().  However, any
# mispelled arguments will not raise an error.

# If you just want to capture the values of the ..., use list(...)


# Lazy Evaluation ---------------------------------------------------------

# Arguments in R are lazily evaluated: they're not computed until they're needed.  That meams if they're never
# used, they're never called.  This is an important property of R as a programming language, but is generally not
# important when you're writing your own functions for data analysis.

commas(letters, collapse = "-+")

# You can fix the problem with pad synatx by using the dot-dot-dot argument
rule <- function(..., pad = "...") {
  title <- paste0(...)
  width <- getOption("width") - nchar(title) - 5
  cat(title, " ", stringr::str_dup(pad, width), "\n", sep = "")
}
# However, this means that the argument needs to be explicit if the user wants a proper output:
rule("Title", pad = "-+")


# Return Values -----------------------------------------------------------

# Figuring out what your function should return is usually straightfoward.  There are two things you should
# consider when returning a value:

  # Does returning early make your function easier to read?
  # Can you make your function pipeable?


# Explicit Return Statements ----------------------------------------------

# The value returned by the function is usually the last statement it evaluates, but you can choose to return
# early by using return().  A common reason to do this is because the inputs are empty:
complication_function <- function(x, y, z) {
  if (length(x) == 0 || length(y) == 0) {
    return(0)
  }
  # Complicated code here
}
# Another reason is because you have a if statement with one complex block and one simple block.  For example,
# you might write an if statement like this:
f <- function() {
  if (x) {
    # Do
    # something
    # that
    # takes
    # many
    # lines
    # to
    # express
  } else {
    # return something short
  }
}

# But if the first block is very long, by the time you get to else, you've forgotten the condition.  One way to
# rewrite it is to use an early return for the simplest case:
f <- function() {
  if (!x) {
    return(something_short)
  }
  
  # Do
  # something
  # that
  # takes
  # many 
  # lines
  # to
  # express
}
# This tends to nake the code easier to understand, because you don't need quite so much context to understand it


# Writing Pipeable Functions ----------------------------------------------

# When writing functions, thinking about the return value is important.  There are two main types of pipeable
# functions: transformations and side-effect.

# In transformation functions, there's a clear 'primary' object that is passed in as the first argument, and a 
# modified version is returned by the function. For example, the key objects for dplyr and tidyr are data frames.
# If you can identify what the object type is for your domain, you'll find that your functions just work with 
# the pipe.

# Side-effect functions are primarily called to perform an action, like drawing a plot or saving a file, not
# transforming an object.  These functions should 'invisibly' return the first argument, so they're not printed
# by default, but can still be used in a pipeline.  For example, this simple function prints out the number of 
# missing values in a data frame:
show_missings <- function(df) {
  n <- sum(is.na(df))
  cat("Missing values: ", n, "\n", sep = "")
  
  invisible(df)
}

# If we call it interactively, the invisible() means that the input df doesn't get printed out:
show_missings(mtcars)
# But, it's still there, it's just not printed by default:
x <- show_missings(mtcars)
class(x)
dim(x)
# And we can still use it in a pipe:
library(tidyverse)
mtcars %>% 
  show_missings() %>% 
  mutate(mpg = ifelse(mpg < 20, NA, mpg)) %>% 
  show_missings()


# Environment -------------------------------------------------------------

# The last component of a function is its environment.  The environment of a function controls how R finds the
# value associated with a name.  Take this function:
f <- function(x) {
  x + y
}
# In many programming languages, this would be an error, because y is not defined inside the function.  In R,
# this is valid code because R ises rules called lexical scoping to find the value associated with a name.  Since
# y is not defined inside the function, R will look in th environment where the function was defined:
y <- 100
f(10)
y <- 1000
f(10)
# The advantage of this behaviour is that from a language standpoint it allows R to be very consistent.  Every
# name is looked up using the same set of rules.  For f() that includes the behaviour of two things that you
# might not expect: { and +.  This allows you to do devious things like: 
'+' <- function(x, y) {
  if (runif(1) < .1) {
    sum(x, y)
  } else {
    sum(x, y) * 1.1
  }
}
table(replicate(1000, 1 + 2))
rm('+')


# Chapter 16: Vectors -----------------------------------------------------
library(tidyverse)


# Vector Basics -----------------------------------------------------------

# Two types of vectors:

  # Atomic vecots, of which there are six types: logical, integer, double, character, complex, and raw.  Integer
# & double vectors are collectively known as numeric vectors.

  # Lists, which are sometimes called recursive vectors ebcayse lists can contain other lists.

# The main difference between atomic vectors and lists is that atomic vectors are homogeneous, while lists can
# be heterogeneous.  There is one other related object: NULL.  NULL typically behaves like a vector of length 0.

# Every vector has two key properties:
# It's type, which you can determine with typeof():
typeof(letters)
typeof(1:10)
# And it;s length, which you can determine with length():
x <- list("a", "b", 1:10)
length(x)

# Vectors can also arbitrary additional metadata in the form of attributes.  These attributes are used to create
# augmented vectors, which build on additional behaviour.  There are four important types of augmented vector:

  # Factors are built on top of integer vectors
  # Dates and date-times are built on top of numeric vectors
  # Data frames and tibbles are built on top of lists


# Important Types of Atomic Vector ----------------------------------------

# The four most important types of atomic vector are logical, integer, double, and character.  


# Logical -----------------------------------------------------------------

# Logical vectors are the simplest type of atomic vector because they take only three possible values: FALSE,
# TRUE, and NA.  Logical vectors are usually constructed with comparison operators, but you can also create them
# by hand with c():
1:10 %% 3 == 0
c(TRUE, TRUE, FALSE, NA)


# Numeric -----------------------------------------------------------------

# Interger & double vectors are known collectively as numeric vectors.  In R, 
# numbers are doubles by default. To make an integer, place a L after the number:
typeof(1)
typeof(1L)

# Doubles are approximations.  Doubles represent floating-point numbers that cannot
# always be precisely represented with a fixed amount of memory.  This means you 
# should consider all doubles to be approximations. For example, what is the square 
# root of the square root of two?
x <- sqrt(2)^2
x
x - 2
# This behaviour is common when working with floating-point numbers: most 
# calculations include some approximation error.  Instead of comparing 
# floating-point numbers using ==, you should use dplyr::near() which allows for 
# some numerical tolerance.

# Integers have one special value, NA; doubles have four, NA, NaN, Inf, and -Inf.  
# All three special values can arise during division:
c(-1, 0, 1) / 0
# Avoid using == to check these other special values.  Instead use the helper 
# functions is.finite(), is.infinite() and is.nan()


# Character ---------------------------------------------------------------

# Character vectors are the most complex type of vector, because each element of a
# character vector is a string, and a string can contain an arbitrary amount of data.


# Using Atomic Vectors ----------------------------------------------------

# There are two ways to convert, or coerce, one type of vector to another:

# Explicit coercion happens when you call a function like as.logical(), as.integer()
# as.double(), or as.character().  Whenever you find yourself using explicit coercion,
# you should always check whether you can make the fix upstream, so that the vector
# never had the wrong type in the first place.  For example, you may need to tweak 
# readr's col_types specification.

# Implicit coercion happens when you use a vector in a specific context that expects
# a certain type of vector.  For example, when you use a logical vector with a 
# numeric summary function, or when you use a double vector where an integer vector
# is expected.

# Because explicit coercion is easy to understand, let's focus on implicit coercion
# and do an example:

# In the case below, TRUE is converted to 1 and FALSE is converted to 0.  That means
# the sum of a logical vectoer is the number of trues, and the means of a logical 
# vector is the proportion of trues.

x <- sample(20, 100, replace = TRUE)
y <- x > 10
sum(y) # hpw many are greater than 10?
mean(y) # what proportion are greater than 10?

# You may see some code (typically older) that relies on implicit coercion in the 
# opposite direction, from integer to logical:
if (length(x)) {
  # do something
}
# In this case, 0 is converted to FALSE and everything else is converted to TRUE.
# This makes it harder to understand your code, and it is not recommended it.
# Instead, be explicit: length(x) > 0

# It is also important to understand what happens when you try and create a vector
# containing multiple types with c() - the default rule is that the most complex type 
# always wins the test:
typeof(c(TRUE, 1L))
typeof(c(1L, 1.5))
tibble(x = 1:4, y = rep(1:2, each = 2))


# Naming vectors ----------------------------------------------------------

# All types of vectors can be named.  You can name them during creation with c():
c(x = 1, y = 2, z = 4)
# Or after the fact with purr::set_names():
purrr::set_names(1:3, c("a", "b", "c"))
# Named vectors are most useful for subsetting.


# Subsetting --------------------------------------------------------------

# Although we have dplyr::filter() to filter the rows in a tibble or data frame, 
# filter() only works with tibble, so we'll need a new tool for vectors: [.] is the 
# subsetting function, and is called like x[a].  There are four types of things that
# you can subset a vector with:

# A numeric vector containing only integers.  The integers must either be positive,
# all negative, or zero.

# Subsetting with positive integers keeps the elements at those positions:
x <- c("one", "two", "three", "four", "five")
x[c(3, 2, 5)]
# By repeating a position, you can actually make a lomger output than an input:
x[c(1, 1, 5, 5, 5, 2)]
# Negative values drop the elements at the specified positions:
x[c(-1, -3, -5)]
# However, it is an error to mix negative and positve values:
x[c(1, -1)]
# Note the error message mentions subsetting with zero, which returns no values:
x[0]
# This is not useful very often, but it can be helpful if you want to create unusual
# data structures to test your functions with.

# Subsetting with a logical vector keeps all values corresponding to a TRUE value.
# This is most useful in conjunction with the comparison functions:
x <- c(10, 3, NA, 5, 8, 1, NA)

# All non-missing values of x:
x[!is.na(x)]
# All even (or missing!) values of x:
x[x %% 2 == 0]

# If you have named a vector, you can subset it with a character vector:
x <- c(abc = 1, def = 2, xyz = 5)
x[c("xyz", "def")]

# Like with positive integers, you can also use a character vector to duplicate 
# individual entries.

# The simplest subsetting of x[] is not for subsetting vectors useful as it returns
# the complete x.  It is however, useful when subsetting matrices (and other 
# high-dimensional structures) because it lets you select all the rows and all the
# columns.  For example, if x is 2D, x[1, ] selects the first row and all the
# columns, and x[, -1]  selects all rows and all columns except the first.

# There is an important variation of subsetting, using double [[]].  [[]] only ever
# extracts a single element, and always drops names.  It is a good idea to use it
# whenever you want to make it clear you're extracting a single item, as in a for
# loop.  The distinction between [] and [[]] is most important for lists.


# Recursive Vectors (Lists) -----------------------------------------------

# Lists are a step up in complexity from atomic vectors, because lists can contain 
# other lists.  This makes them suitable for representing hierarchical or tree-like
# structures.  You create a list with list():
x <- list(1, 2, 3)
x

# A very useful tool for working with lists is str() becayse it focuses on the
# structure, not the contents:
str(x)

x_named <- list(a = 1, b = 2, c = 3)
str(x_named)

# Lists can even contain other lists!
z <- list(list(1, 2), list(3, 4))
str(z)


# Subsetting  -------------------------------------------------------

# There are three ways to subset a list:
a <- list(a = 1:3, b = "s string", c = pi, d = list(-1, -5))

# [] extracts a subset.  The result will always be a list:
str(a[1:2])
str(a[4])

# [[]] extracts a single component from a list.  It removes a level of hierarchy from the list:
str(a[[4]])

# $ is a shorthand for extracting named elements of a list.  It works similarily to [[]] except
# that you don't need to use quotoes
a$a
# versus
a[["a"]]

# The distinction between [] & [[]] is really important for lists, because [[]] drills down
# into the list while [] returns a new, smaller list.  


# Attributes --------------------------------------------------------------

# Any vector can contain arbitrary additional metadara through its attributes. You can think 
# of attributes as a named list of vectors that can be attached to any object.  You can get
# and set individual attribute values with attr() or see them all at once with attributes():
x <- 1:10
attr(x, "greeting")
attr(x, "greeting") <- "Hi!"
attr(x, "farewell") <- "Bye!"
attributes(x)

# There are three important attributes that are used to implement fundamental parts of R:
  # 1.Names are used to name the elements of a vector.
  # 2.Dimensions (dims, for short) make a vector behave like a matrix or array.
  # 3.Class is used to implement the S3 object-orientated system.


# Augmented Vectors -------------------------------------------------------

# Atomic vectors and lists are the building blocks for other important vector types like
# factors and dates.  These are called augmented vectors, because they are vectors with 
# additional attributes, inlcuding class.  Because augmented vectors have a class, they behave
# differently to the atomic vector on which they are built:

  # Factors,
  # Date-times and times,
  # Tibbles

# These are augmented vectors used in this book.


# Factors -----------------------------------------------------------------

# Factors are designed to represent categorical data that can take a fixed set of possible
# values.  Factors are built on top of integers, and have a levels attribute:
x <- factor(c("ab", "cd", "ab"), levels = c("ab", "cd", "ef"))

typeof(x)

attributes(x)


# Dates and Date-Times ----------------------------------------------------

# Dates in R are numeric vectors that represent the number of days since 1 January 1970:
x <- as.Date("1971-01-01")

unclass(x)

typeof(x)

attributes(x)

# Date-Times are numeric vectors with class POSIXct that represent the number of seconds since
# 1 January 1970:
x <- lubridate::ymd_hm("1970-01-01 01:00")

unclass(x)

typeof(x)

attributes(x)
# The tzone attribute is optional.  It contropls how the time is printed, not what absolute
# time it refers to:
attr(x, "tzone") <- "US/Pacific"
x
attr(x, "tzone") <- "US/Eastern"
x

# There is another type of date-times called POSIXlt.  These are built on top of named lists:
y <- as.POSIXlt(x)
typeof(y)
attributes(y)


# Tibbles -----------------------------------------------------------------

# Tibbles are augmented lists.  They have three class: tbl_df, tbl, and data.frame.  They have
# two attributes: (column) names and row.names:
tb <- tibble::tibble(x = 1:5, y = 5:1)
typeof(tb)

# Traditional data.frames have a very similar structure:
df <- data.frame(x = 1:5, y = 5:1)
typeof(df)
attributes(df)
# The main difference is the class.  The class of tibble includes data.frame, which means
# tibbles inherit the regular data frame behaviour by default.  

# The difference between a tibble or a data frame and a list is that all of the elements of a
# tibble or data frame must be vectors with the same length.  All functions that work with
# tibbles enforce this constraint.

z <- hms::hms(3600)
typeof(z)
attributes(z)


# Chapter 17: Iteration with purrr ----------------------------------------
library(tidyverse)


# For Loops ---------------------------------------------------------------

# Imagine we have this simple tibble:
df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)
# We want to compute the median of each column.  You could do it with copy & paste:
median(df$a)
median(df$b)
median(df$c)
median(df$d)
# But that breaks a rule of thumb: never copy and paste more than twice! Instead, we could
# use a for loop:
output <- vector("double", ncol(df)) # 1. output
for ( i in seq_along(df)) {
  output[[i]] <- median(df[[i]])
}
output

# Every for loop has three components:

  # 1. output: output <- vector("double", length(x))

  # Before you start the loop, you must always allocate sufficient space for the output.  This
  # is very important for efficiency: if you grow the for loop at each iteration using c()
  # for example, your for loop will bery very slow. A general wat of creating an empty vector
  # of given length is the vector() function. It has two arguments: the type of the vector
  # ('logical', 'integer', 'double', 'character', etc) and the length of the vector.

  # 2. sequence i in seq_along(df)
  
  # This determines what to loop over: each run of the for loop will assign i to a different
  # value from the seq_along(df). It's useful to think of i as a pronoun, like 'it'. seq_along()
  # is a safe version of 1:length(l), with an important difference: if you have a zero length 
  # vector, seq_along() does the right thing:
y <- vector("double", 0)
seq_along(y)
1:length(y)
# Although one probably wont create a zero length vector intentionally, it can be done 
# accidently, therefore uing seq_along(x) is a safer choice.

  # 3. body output[[i]] <- median(df[[i]])
  
  # This is the code that does the work. It's run repeatedly, eaceh time with a different value
  # for i.  The first iteration will run out put[[1]] <- median(df[[1]]), the second will run
  # out put[[2]] <- median(df[[2]]), and so on.

# Compute the mean for every column in mtcars using a for loop:
data("mtcars")
mtcars

mtcars_col_mean <- vector("double", ncol(mtcars))
names(mtcars_col_mean) <- names(mtcars)
for (i in seq_along(mtcars)) {
  mtcars_col_mean[[i]] <- mean(mtcars[[i]])
}
mtcars_col_mean


# Determine the type of each column in nycflights13::flights:
library(nycflights13)
flights_col_type <- list(flights, ncol(flights))
names(flights_col_type) <- names(flights)
for (i in seq_along(flights)) {
  flights_col_type[[i]] <- typeof(flights[[i]])
}
flights_col_type

# Compute the number of unique values in each column of iris:
iris
iris_uniq <- vector("double", ncol(iris))
names(iris_uniq) <- names(iris)
for (i in seq_along(iris)) {
  iris_uniq[[i]] <- length(unique(iris[[i]]))
}
iris_uniq

# Generate 10 random normals for each of $\mu$ = -10, 0, 10, and 100.
n <- 10 # Number to generate
mu <- c(-10, 0, 10, 100) # Values of the mean
normals <- vector("list", length = mu) # create list of normals
for (i in seq_along(normals)) {
  normals[[i]] <- rnorm(n , mean = mu[i])
}
normals
# However, we don't need a for loop for this since `rnorm()` recycle the `mean` argument.
matrix(rnorm(n * length(mu), mean = mu), ncol = n)

# Eliminate the for loop in each of the following examples by taking advantage of an existing
# function that works with vectors:
out <- ""
for (x in letters) {
  out <- stringr::str_c(out, x)
}
# versus
stringr::str_c(letters, collapse = "")

x <- sample(100)
stand_d <- 0
for (i in seq_along(x)) {
  stand_d <- stand_d + (x[i] - mean(x))^2
}
stand_d <- sqrt(stand_d / length(x - 1))
stand_d
# versus
sd(x)
# or
sqrt(sum((x - mean(x))^2) / (length(x) - 1))

x <- runif(100)
out <- vector("numeric", length(x))
out[1] <- x[1]
for (i in 2:length(x)) {
  out[i] <- out[i - 1] + x[i]
}
# The above calculates cumsum:
cumsum(x)
# Are output and cumsum == ? Using a logical test of all.equal():
all.equal(cumsum(x), out) # TRUE.

# Write a for loop that prints the lyrics to the song 'Alice the Camel'.
# The lyrics for Alice the Camel are:
  
# Alice the camel has five humps.
# Alice the camel has five humps.
# Alice the camel has five humps.
# So go, Alice, go.

# This verse is repeated, each time with one fewer hump, until there are no humps. 
# The last verse, with no humps, is:
  
# Alice the camel has no humps.
# Alice the camel has no humps.
# Alice the camel has no humps.
# Now Alice is a horse.

# Iterate from five to no humps, and print out a different last line if there are no humps:
humps <- c("five", "four", "three", "two", "one", "no")
for (i in humps) {
  cat(stringr::str_c("Alice the camel has ", rep(i, 3), "humps.",
            collapse = "\n"),
      "\n")
  if (i == "no") {
    cat("Now Alice is a horse.\n")
  } else {
    cat("So go, Alice, go.\n")
  }
  cat("\n")
}

# Convert the nursery rhyme 'Ten in the Bed' to a function.  Generalise it to any number of
# people in any sleeping structure.

# Lyrics:

# Here we go!
# There were ten in the bed
# and the little one said,
# “Roll over, roll over.”
# So they all rolled over and one fell out.

# This verse is repeated, each time with one fewer in the bed, until there is one left. That 
# last verse is:

# One! There was one in the bed
# and the little one said,
# “I’m lonely…”
numbers <- c("ten", "nine", "eight", "seven", "six", "five",
             "four", "three", "two", "one")
for (i in numbers) {
  cat(stringr::str_c("There were ", i, " in the bed\n"))
  cat("and the little one said\n")
  if (i == "one") {
    cat("I'm lonely...")
  } else {
    cat("Roll over, roll over\n")
    cat("So they all rolled over and one fell out.\n")
  }
  cat("\n")
}

# Convert the song '99 Bottles of Beer on the Wall' to a function.  Generalise it to any number
# of any vessel containing any liquid on any surface:
bottles <- function(n) {
  if (n > 1) {
    stringr::str_c(n, " bottles")
  } else if (n == 1) {
    "1 bottle"
  } else {
    "no more bottles"
  }
}

beer_bottles <- function(total_bottles) {
  for (current_bottles in seq(total_bottles, 0)) {
    cat(stringr::str_to_sentence(stringr::str_c(bottles(current_bottles), 
                                                " of beer on the wall, ", 
                                                bottles(current_bottles), " of beer.\n")))
    if (current_bottles > 0) {
      cat(stringr::str_c(
        "Take one down and pass it around, ", bottles(current_bottles - 1), 
        " of beer on the wall.\n"
      ))
    } else {
      cat(stringr::str_c("Go to the store and buy some more, ", bottles(total_bottles), 
                         " of beer on the wall.\n"))
    }
    cat("\n")
  } 
}
beer_bottles(5)

# It's common to see for loops that preallocate the output and instead increase the length of
# a vector at each step:
output <- vector("integer", 0)
for (i in seq_along(x)) {
  output <- c(output, length(x[[i]]))
}
# In order to compare these two approaches, I’ll define two functions: add_to_vector will 
# append to a vector, like the example in the question, and add_to_vector_2 which 
# pre-allocates a vector:

add_to_vector <- function(n) {
  output <- vector("integer", 0)
  for (i in seq_len(n)) {
    output <- c(output, i)
  }
  output
}
add_to_vector_2 <- function(n) {
  output <- vector("integer", n)
  for (i in seq_len(n)) {
    output[[i]] <- i
  }
  output
}

# I’ll use the package microbenchmark to run these functions several times and compare the 
# time it takes. The package microbenchmark contains utilities for benchmarking R expressions.
# In particular, the microbenchmark() function will run an R expression a number of times and 
# time it.
library(microbenchmark)
timings <- microbenchmark(add_to_vector(10000), add_to_vector_2(10000), times = 10)
timings


# For Loop Variations -----------------------------------------------------

# There are some for loop variations from the basic for loop to be aware of.  These variations
# are important regardless of how you do iterations, so don't forget about them once you've 
# mastered the FP techniques.

# There are four variations on the basic theme of the for loop:
# 1. Modifying an existing object, instead of creating a new object.
# 2. Looping over names or values, instead of indices.
# 3. Handling outputs of unknown length.
# 4. Handling sequences of unknown length.


# Modifying an Existing Object --------------------------------------------

# Sometimes you will want to modify an existing object using a for loop. Rescale the every
# column in this data frame:
library(tibble)
df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}
df$a <- rescale01(df$a)
df$b <- rescale01(df$b)
df$c <- rescale01(df$c)
df$d <- rescale01(df$d)
# To solve this with a for loop we again think about the three components:
  # Output: we already have the output - it's the same as the input!

  # Sequence: We can think about a data frame as a list of columns, so we can iterate over
  # each column with seq_along(df)

  # Body: apply rescale01()

# This gives us:
for (i in seq_along(df)) {
  df[[i]] <- rescale01(df[[i]])
}
df
# Typically you'll be modifying a list or data frame with this sort of loop, so remember to use
# [[]], not [].  You might have spotted that we used [[]] in all of the for loops: it is better
# to use [[]] even for atomic vectors because it makes ti clear that you want to work with a
# single element.


# Looping Patterns --------------------------------------------------------

# There are three basic ways to loop over a vector. So far, we have worked on the most general:
# looping over the numeric indices with for (i in seq_along(xs)), and extracting the value with
# x[[i]]. There are two other forms:

# 1. Loop over the elements: for (x in xs). This is the most useful if you only care about side
# effects, like plotting or saving a file, because it's difficult to save the output directly.

# 2. Loop over the names: for (nm in names(xs)). This gives you a name, which you can use to
# access the value with x[[nm]]. This is iseful if you want to use the name in a plot or a 
# filename.

# If you're creating named output, make sure to name the results vector like so:
results <- vector("list", length(x))
names(results) <- names(x)

# Iteration over the numeric indices is the most general form, because given the position you
# can extract both the name and the value:
for (i in seq_along(x)) {
  name <- names(x)[[i]]
  value <- x[[i]]
}


# Unknown Output Length ---------------------------------------------------

# Sometimes you might want to onow how long the output will be. For example, imagine you want
# to simulate some random vectors of random lengths. You might be tempted to solve this 
# problem by progressively growing the vector:
means <- c(0, 1, 2)

output <- double()
for (i in seq_along(means)) {
  n <- sample(100, 1)
  output <- c(output, rnorm(n, means[[i]]))
}
stringr::str_c(output)
# But this is not very efficient because in each iteration, R has to copy all the data from the
# previous iterations. In technical terms you get 'quadratic' (O(n^2)) behaviour, which means
# that a loop with three times as many elements would take nine times as long to run!

# A better solution is to save the result in a list, and then combine into a single vector
# after the loop is done:
out <- vector("list", length(means))
for (i in seq_along(means)) {
  n <- sample(100, 1)
  out[[i]] <- rnorm(n, means[[i]])
}
str(out)
# Now you can use unlist() to dlatten a list of vectors into a single vector.
str(unlist(out))
# A stricter option is to use purr::flatten_dbl() - it will throw an error if the input isn't
# a list of doubles.

# This pattern occurs in other places too:
  # You might be generating a long string. Instead of paste()ing together each iteration with
  # the previous, save the output in a character vector and then combine that vector into a
  # single string with paste(output, collapse = "").

  # You might be generating a big data frame. Instead of sequentially rbind()ing in each
  # iteration, save the output in a list, then use dplyr::bind_rows(output) to combine the
  # output into a single data frame.


# Unknown Sequence Length -------------------------------------------------

# Sometimes you don't even know how long the input sequence should be. This is common when
# doing simulations. For example, you might want to loop until you get three heads in a roll 
# for a coin toss. You can't do that sort of iteration with the for loop. Instead, you can use
# a while loop. A while loop is simpler than a for loop because it only has two components, a
# condition and a body:
while (condition) {
  #body
}
# A while loop is also more general than a for loop, because yopu can rewrite any for loop as a
# while loop, but you can't rewrite every while loop as a for loop:
for (i in seq_along(x)) {
  # body
}
# Equivalent to
i <- 1
while (i <= length(x)) {
  #body
  i <- i + 1
}
# Here's how we could yse a while loop to find how many tries it takes to get three heads in a
# row:
flip <- function() sample(c("T", "H"), 1) 

flips <- 0
nheads <- 0

while (nheads < 3) {
  if (flip() == "H") {
    nheads <- nheads + 1
  } else {
    nheads <- 0
  }
  flips <- flips + 1
}
flips

# Write a function that prints the mean of each numeric column in a data frame, along with its
# name.

# There may be other functions to do this, but I’ll use str_pad(), and str_length() to ensure 
# that the space given to the variable names is the same. I messed around with the options to 
# format() until I got two digits.

  # Create a function with the format of rounding output to two digits:
show_mean <- function(df, digits = 2) {
  # Get max length of all column names in the dataset,  
  # using str_pad & str_length to make sure that the numbers line up nicely, 
  # even though the column names have different lengths:
  maxstr <- max(str_length(names(df)))
  # For numeric means in each column names of the data frame (this is to ensure that
  # output is associated with each column name),
  for (i in names(df)) {
    # if vector is numeric, concatanate the column name, numerical mean & print:
    if (is.numeric(df[[i]])) {
      cat(
        # Note: the prior object maxstr is used to make the output digits line up:
        str_c(str_pad(str_c(i, ":"), width = maxstr + 1L, side = "right"),
              format(mean(df[[i]], na.rm = TRUE), digits = digits, nsmall = digits),
              sep = " "
              ),
        # add space between each iteration:
        "\n"
      )
    }
  }
}
show_mean(iris)
# You can use this function with any data set:
show_mean(mtcars)
show_mean(nycflights13::flights)


# For Loops Versus Functionals --------------------------------------------

# For loops are notas important in R as functions because R is a functional programming
# language. This means that it possible to wrap up for loops in a function, and call that 
# function instead of using the for loop directly!

# For example, consider this simple data frame:
df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

# Imagine you want to compute the mean of every column:
output <- vector("double", length(df))
for (i in seq_along(df)) {
  output[[i]] <- mean(df[[i]])
}
output

# However, what happens if you wanted to compute the means pretty frequently?
col_mean <- function(df) {
  output <- vector("double", length(df))
  for (i in seq_along(df)) {
    output[[i]] <- mean(df[[i]])
  }
  output
}

# But then it could also be helpfil to be able to compute the median, and the SD, so you copy
# and paste your col_mean() function and replace the mean with the median and sd. This however,
# would lead you to copying something twice! Therefore, we can add an additional argument to 
# the function in order to specify the type of summary statistic you desire:
col_summary <- function(df, fun) {
  out <- vector("double", length(df))
  for (i in seq_along(df)) {
    out[[i]] <- fun(df[[i]])
  }
  out
}
col_summary(df, median)
col_summary(df, mean)
col_summary(df, sd)

# The idea of passing a function to another function is an extremely powerful idea, and it is
# one of the behaviours that makes R a function programming language.
col_summary <- function(df, fun) {
  out <- vector("double", length(df))
  for (i in seq_along(df)) {
    out[[i]] <- fun(df[[i]])
  }
  out
}

# Adapted to only apply to numeric columns within a data set:
col_summary <- function(df, fun) {
  # create an empty vector which will 
  # store whether each column is numeric:
  numeric_cols <- vector("logical", length(df))
  # then test whether each columnn is numeric:
  for (i in seq_along(df)) {
    numeric_cols[[i]] <- is.numeric(df[[i]])
  }
  # then find indexes of the numeric columns:
  index_Lcols <- which(numeric_cols)
  # sum number of numeric columns:
  n <- sum(numeric_cols)
  # create vector to store results of above:
  out <- vector("double", n)
  # then apply the called statistical function to
  # only the numeric vectors within given object:
  for (i in seq_along(index_Lcols)) {
    out[[i]] <- fun(df[[index_Lcols[[i]]]])
  }
  # name the vector
  names(out) <- names(df[[index_Lcols]])
  out
}
df <- tibble(
  X1 = c(1, 2, 3),
  X2 = c("A", "B", "C"),
  X3 = c(0, -1, 5),
  X4 = c(TRUE, FALSE, TRUE)
)
col_summary(df, mean)

df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)
# The Map Functions -------------------------------------------------------

# map() makes a list.

# map_lgl() makes a logical vector.

# map_int() makes an integer vector.

# map_dbl() makes a double vector.

# map_chr() makes a character vector.

# The chief benefit of using functions like map() over for loops is not speed, but clarity:
# they make your code easier to write and read. For example, here are map functions which do 
# the same function as the ones written above:
map_dbl(df, mean)
map_dbl(df, median)
map_dbl(df, sd)
# Compared to using a for loop, focus is on the operation being performed, not the bookkeeping
# required to loop every element and store the outoput. This is even more apparent if we use
# the pipe:
df %>% 
  map_dbl(mean)

df %>% 
  map_dbl(median)

df %>% 
  map_dbl(sd)

# There are a few differences between map and col_summary:
# All purr functions are implemented in C, making them a little faster!
# The second argument, .f, the function to apply, can be a formula, a character vector, or an
# integer vector.
# Map uses ... to pass along additional arguments to .f each time it's called:
map_dbl(df, mean, trimw = .5)

# The map functions also preserve names:
z <- list(x = 1:3, y = 4:5)
map_int(z, length)


# Shortcuts ---------------------------------------------------------------

# There are a few shortcuts that you can use with .f in order to save a littl typing. Imagine
# you want to fit a linear model to each group in a dataset. The following toy example splits
# up the mtcars dayatset into three pieces (one for each value of cylinder) and fits the same
# linear model to each piece:
models <- mtcars %>% 
  split(.$cyl) %>% 
  map(function(df) lm(mpg ~ wt, data = df))

# The syntax for creating an anonymous function in R is quite verbose so purr provides a 
# convienient shprtcut - a one-sided formula:
models <- mtcars %>% 
  split(.$cyl) %>% 
  map(~lm(mpg ~ wt, data = .))
# Here, . is used as a pronoun: it refers to the current list element (in the same way that
# i referred to the current index in the for loop).

# When you're looking at many models, you might want to extract a summary statistic, like the
# R2. To do that we need to first run summary() and then extract the component called
# r.squared. We could do that using the shorthand for anonymous functions:
models %>% 
map(summary) %>% 
  map_dbl(~ .$r.squared)
# But extracting named components is a common operation, so purr provides an even shorter
# shortcut: you can use a string:
models %>% 
  map(summary) %>% 
  map_dbl("r.squared")
# You can also use an integer to select elements by position:
x <- list(list(1, 2, 3), list(4, 5, 6), list(7, 8, 9))
x %>% 
  map_dbl(2)


# Base R ------------------------------------------------------------------

# If you're familiar with the apply family of functions in base R, you might have noticed
# some similarities with the purr functions:

# lapply() is basically identical to map(), except that map() is consistent with all the other
# functions in purr, and you can use the shortcuts for .f

# Base sapply() is a wrapper around lapply() that automatically simplifies the output. This
# is useful for interactive work but is problematic in a function because you can never know
# what sort of output you'll get:
x1 <- list(
  c(.27, .37, .57, .91, .2),
  c(.9, .94, .66, .63, .06),
  c(.21, .18, .69, .38, .77)
)
x2 <- list(
  c(.5, .72, .99, .38, .78),
  c(.93, .21, .65, .13, .27),
  c(.39, .01, .38, .87, .34)
)

threshold <- function(x, cutoff = .8) x[x > cutoff]

x1 %>%
  sapply(threshold) %>% 
  str()
x2 %>% 
  sapply(threshold) %>% 
  str()

# Compute mean of every column of mtcars using map functions:
map_dbl(mtcars, mean)
# Determine the type of each column in flights using map:
map_chr(nycflights13::flights, typeof)

# Compute the number of unique values in each column of irirs:
# There is no function that directly calculates the number of unique values in a vector. 
# For a single column, the number of unique values of a vector can be calculated like so,
length(unique(iris$Species))


# To apply this to all columns, we can provide the map an anonymous function. We can write 
# anonymous function using the standard R syntax:
map_int(iris, function(x) length(unique(x)))
# We could also use the compact, one-sided formula shortcut that purrr provides.
map_int(iris, ~ length(unique(.)))


# To generate 10 random normals for each of μ = − 10, 0, 10, and 100.
map(c(-10, 0, 10, 100), ~ rnorm(n = 10, mean = .))
# Note: remember . is used as a pronoun: it refers to the current list element (in the same 
# way that i referred to the current index in a for loop). So here, . represents the mapped
# arguments of c(-10, 0, 10, 100) generating 10 random scalar values withinin 4 columns with
# means of -10, 0, 10, and 100, respectively.


# Dealing with Failure ----------------------------------------------------
library(tidyverse)
# Specifically when using map() functions, it is much easier to encounter failure. safely() 
# takes a function and returms a modified version. In this case, the modified function will
# never throw an error. Instead, it always returns a list with two elements. For example:

safe_log <- safely(log)
str(safe_log(10))
str(safe_log("a"))

# When the function succeeds, the result element contains the result and the error element in
# NULL. When the function fails, the results element is NULL and the error element contains
# an error object.

# safely() is designed to work with map:
x <- list(1, 10, "a")
y <- x %>% 
  map(
    safely(log)
  )
str(y)

# This would be easier to work with if we had two lists: one of all the errors and one of all
# the output. That's easy to get with purr::transpose:
y <- y %>% 
  transpose()
str(y)

# Typically you'll either look at the values of x where y is an error, or work with the values
# of y that are okay:
is_ok <- y$error %>% 
  map_lgl(is_null)

y$result[is_ok] %>% 
  flatten_dbl()

# purr provides two other useful adverbs:

# Like safely(), possibly() always succeeds. It's simpler than safely(), because you give it
# a default value to return when there is an error:
x <- list(1, 10, "a")
x %>% 
  map_dbl(possibly(log, NA_real_))

# quietly() performs a similar role to safely(), but instead of capturing errors, it captures
# printed output, messages, and warnings:
x <- list(1, -1)
x %>% 
  map(quietly(
    log
  )) %>% 
  str()


# Mapping over Multiple Arguments -----------------------------------------

# Often you have multiple related inputs that you need to iterate along in parallel. This is 
# the job of the map2() and pmap() functions. For example, imagine you'd want to simulate 
# some random normals wih different means. You know how to do it with map():
mu <- list(5, 10, -3)
mu %>% 
  map(rnorm, n= 5) %>% 
  str()
# What if you also want to vary the standard deviation? One way to do that would be to iterate
# over the indices and index into vectors of means and sds:
sigma <- list(1, 5, 10)
seq_along(mu) %>% 
  map(~ rnorm(5, mu[[.]], sigma[[.]])) %>% 
  str()
# But that obfuscates the intent of the code. Instead you could use map2(), which iterates 
# over two vectors in parallel:
map2(mu, sigma, rnorm, n = 5) %>% 
  str()
# pmap() is used for wrapping arguments > 2. For example, you might want to use pmap() if you
# wanted to vary the mean, standard deviation, and number of samples:
n <- list(1, 3, 5)
args1 <- list(n, mu, sigma)
args1 %>% 
  pmap(rnorm) %>% 
  str()
# If you don't name the elements of list, pmap() will use positional matching when calling the
# function. That's a little fragile and unreliable, and makes the code harder to read, so it
# is better to name the arguments explicitly:
args2 <- list(mean = mu, sd = sigma, n = n)
args2 %>% 
  pmap(rnorm) %>% 
  str()
# Since all the arguments are all the same length, it makes sense to store them in a data
# frame:
params <- tribble(
  ~mean, ~sd, ~n,
      5,   1,  1,
     10,   5,  3, 
     -3,  10,  5
)
params %>% 
  pmap(rnorm)


# Invoking Different Functions --------------------------------------------

# As well as varying the arguments to the function you might also vary the function itself:
f <- c("runif", "rnorm", "rpois")

params <- list(
  list(min = -1, max = 1), 
  list(sd = 5), 
  list(lambda = 10)
  )

# To handle this case you can use invoke_map():
invoke_map(f, n = 5, params) %>% 
  str()
# Again, you can use tribble to make creating these mathcing pairs a little easier:
sim <- tribble(
  ~ f, ~ params,
  "runif", list(min = -1, max = 1),
  "rnorm", list(sd = 5),
  "rpois", list(lambda = 10)
)
sim %>% 
  mutate(sim = invoke_map(f, params, n = 10))


# Walk --------------------------------------------------------------------

# Walk is an alternative to map that you may use when you want to call a function for its 
# side effects, rahter than for its return value. You typically do this because you want to
# render output to the screen or save files to disk - the important thing is the action, not
# the return value. Here's a simple example:
x <- list(1, "a", 3)
x %>% 
  walk(print)
# walk() is generally not that useful compared to walk2() or pwalk(). For example, if you had
# a list of plots and a vector of filenames, you could use pwalk() to save each file to the
# corresponding location on disk:
library(ggplot2)

plots <- mtcars %>% 
  split(.$cyl) %>% 
  map(~ggplot(., aes(mpg, wt)) + geom_point())

paths <- stringr::str_c(names(plots), ".pdf")

pwalk(list(paths, plots), ggsave, path = tempdir())


# Other Patterns for For Loops --------------------------------------------

# purr provides a number of other functions that abstract over other types of for loops. 
# You'll use them less frequently than the map functions, but they're useful to know about.


# Predicate Functions -----------------------------------------------------

# A number of functions work with predicate functions that return either a single TRUE or
# FALSE.

# keep() and discard() keep elements of the input where the predicate is TRUE and FALSE, 
# respectively:
iris %>% 
  keep(is.factor) %>% 
  str()

iris %>% 
  discard(is.factor) %>% 
  str()

# some() and every() determine if the predicate is true for any or for all elements:
x <- list(1:5, letters, list(10))
x %>% 
  some(is_character)
x %>% 
  every(is_vector)

# detect() finds the first elements where the predicate is true, detect_index() returns its
# position:
x <- sample(10)
x

x %>% 
  detect(~ . > 5)

x %>% 
  detect_index(~ . > 5)

# head_while() and tail_while() take elements from the start or end of a vector while a 
# predicate is true:
x %>% 
  head_while(~ . > 5)

x %>% 
  tail_while(~ . > 5)


# Reduce & Accumulate -----------------------------------------------------

# Sometime you have a complex list that you want to reduce to a simple list by repeatedly 
# applying a function that reduces a pair to a singleton. This is useful if you want to apply
# a two-table dplyr verb to multiple tables. For example, you might have a list of data 
# frames, and you want to reduce a single data frame by joining the elements together:
dfs <- list(
  age = tibble(name = "John", age = 30),
  sex = tibble(name = c("John", "Mary"), sex = c("M", "F")),
  trt = tibble(name = "Mary", treatment = "A")
)

dfs %>% 
  reduce(full_join)

# Or maybe you have a list of vectors, and you want to find the intersection:
vs <- list(
  c(1, 3, 5, 6, 10),
  c(1, 2, 3, 7, 8, 10),
  c(1, 2, 3, 4, 8, 9, 10)
)

vs %>% 
  reduce(union)
# or even union of sets:
vs %>% 
  reduce(union)

# The reduce() function takesa a binary function and applies it repeatedly to a list until 
# there is only a single element left.

# Accumulate is similar but it keeps all the interim results. You could use it to implement
# a cumulative sum:
x <- sample(10)
x

x %>% 
  accumulate(`+`)



# Chapter 18: Model Basic with modelr -------------------------------------
library(tidyverse)
library(modelr)

options(na.action = na.warn)

# The goal of a model is not to uncover the truth, but to discover a simple approximation that
# is still useful.


# A Simple Model ----------------------------------------------------------

# The following simple set contains two continuous variables (x & y). Plot them to visualise
# their relation:

ggplot(sim1, aes(y = y, x = x)) +
  geom_point()

# From the plot, you can see a strong linear pattern in the data. Let's use a model to capture
# that apptern and make it explicit. It's our job to supply the basic form of the model. In 
# this case, the relationship looks linear, i.e. y = a_0 + a_!1*x1. Let's start by getting a 
# feel for what models from that family look like by randomly generating a few and overlaying
# them on the data. For this simple case, we can use geom_abline(), which takes a slope and 
# intercept as parameters:
models <- tibble(
  a1 = runif(250, -20, 40),
  a2 = runif(250, -5, 5)
)

ggplot(sim1, aes(y = y, x = x)) +
  geom_abline(
    aes(intercept = a1, slope = a2),
    data = models, alpha = .25
  ) +
  geom_point()

# There are 250 models on this plot, but a lot are really bad! We need to find the good models 
# by making precise our intution that a good model is "close" to the data. We need a way to
# quantify the distance between the data and a model. Then we can fit the model by finding the
# values of a_0 & a_1 that generate the model with the smallest distance from this data.

# One easy place to start is to find the vertical distance between each point on the model. 
# This distance is just the distance between the y value given by the model (the prediction)
# and the actual y value in the data (the response).

# To compute this distance, we furst turn our model family into an R function. This takes the 
# model parameters and the data as inputs, and gives values predicted by the model as output:
model1 <- function(a, data) {
  a[1] + data$x * a[2]
}
model1(c(7, 1.5), sim1)
# Next we need a way to compute an overall distance between the predicted and actual values.
# The plot shows 30 distances, but how do we collapse that into a single number? 

# One common way to do this in statistics is to use the Root-Mean-Squared-Deviation. We can
# compute the difference between the actual and predicted, square them, average them, and
# then take the square root:
measure_dist <- function(mod, data) {
 diff <- data$y - model1(mod, data)
 sqrt(mean(diff ^ 2))
}
measure_dist(c(7, 1.5), sim1)

# Now we can use purr to compute the distance for all the models defined previously. We need 
# a helper function because our distance function expects the model as a numeric vector of
#  length 2:
sim1_dist <- function(a1, a2) {
  measure_dist(c(a1, a2), sim1)
}

models <- models %>% 
  mutate(dist = map2_dbl(a1, a2, sim1_dist))
models
# Next, let's overlay the 10 best models on to the data. Colour the models by -dist: this is
# an easy way to make sure that the best models get the brightest colours!
ggplot(sim1, aes(y = y, x = x)) +
  geom_point(size = 2, colour = "grey30") +
  geom_abline(
    aes(intercept = a1, slope = a2, colour = -dist),
    data = filter(models, rank(dist) <= 10)
  )

# We can also think about these models as observations, and visualise them with a scatterplot
# of a1 versus a2, again coloured by -dist. We can no longer directly see how the model
# compares to the data, but we can see many models at once:
ggplot(models, aes(y = a2, x = a1)) +
  geom_point(
    data = filter(models, rank(dist) <= 10),
    size = 4, colour = "red"
  ) +
  geom_point(aes(colour = -dist))

# Instead of trying lots of random models, we could be more systematic and generate an evenly
# spaced grid of points (this is called a grid search). The parameters of the grid are picked
# by roughly looking at where the best models were in the preceding plot:
grid <- expand.grid(
  a1 = seq(-5, 20, length = 25),
  a2 = seq(1, 3, length = 25)
) %>% 
  mutate(dist = map2_dbl(a1, a2, sim1_dist))

grid %>% 
  ggplot(aes(y = a2, x = a1)) +
  geom_point(
    data = filter(grid, rank(dist) <= 10),
    size = 4, colour = "red"
  ) +
  geom_point(aes(colour = -dist))

# When you overlay the best 10 models back on the original data, they all look pretty good:
ggplot(sim1, aes(y = y, x = x)) +
  geom_point(size = 2, colour = "grey30") +
  geom_abline(
    aes(intercept = a1, slope = a2, colour = -dist),
    data = filter(grid, rank(dist) <= 10)
  )

# You could imagine iteratively making the grid finer and finer until you narrowed in on the 
# best model. But there's a better way to tackle that problem: a numerical minimisation tool
# called Newton-Ralphson serach. The intuition of Newton-Ralphson is pretty seimple: you pick
# a starting point and look around for the steepest slope. You then ski down that slope a 
# little way, and then you repeat again and again, until you can't go any lower. In R, you
# can do that with optim():
best <- optim(c(0, 0), measure_dist, data = sim1)
best$par

ggplot(sim1, aes(y = y, x = x)) +
  geom_point(size = 2, colour = "grey30") +
  geom_abline(intercept = best$par[1], slope = best$par[2])
# However, there is a much simpler tool for fitting linear models: lm()
sim1_mod <- lm(y ~ x, data = sim1)
coef(sim1_mod)

# However, it is also very useful to see what the model doesn't capture, to residual errors
# of models; residuals that are left over after substracting the predictions from the data.
# Residuals are powerful becayse they allow us to use models to remove striking patterns so
# we can study the subtler trends that remain.


# Predictions -------------------------------------------------------------

# To visualise the predictions from a model, we start by generating an evenly spaced grid of
# values that covers the region where our data lies. The easyesr way to do this is to use
# data_grid() from the modelr package. Its first argument is a data frame, and for each 
# sibsequent argument it finds the unique variables and then genrates all combinations:
grid <- sim1 %>% 
  data_grid(x)
grid
# This gets more interesting when more variables are added to the model!

# Next we add predictions. We'll use the modelr::add_predictions(), which takes a data frame
# and a model. It adds the predictions from the model to a new column in the data frame:
grid <- grid %>% 
  add_predictions(sim1_mod)
grid
# Next, we plot the predictions. The advantage of these functions compared to geom_abline is
# that this approach will work with any model in R, from the simplest to the most complex.

ggplot(sim1, aes(x = x)) +
  geom_point(aes(y = y)) +
  geom_line(
    aes(y = pred),
    data = grid,
    colour = "red",
    size = 1
  )


# Residuals ---------------------------------------------------------------

# The flip side of predictions are residuals. The residuals tell you what the model has 
# missed. The resuduals are just the distances between the observed and the predicted values
# that we computed.

# We add residuals to the data with add_residuals(), which works much like add_predicitions().
# Note, however, that we use the original dataset, not a manufactured grid. This is because
# to compute residuals we need actual y values:
sim1 <- sim1 %>% 
  add_residuals(sim1_mod)
sim1
# There are a few different ways to understand what the residuals tell us about the model. 
# One way is to simply draw a frequency polygon to help us understand the spread of the 
# residuals:
ggplot(sim1, aes(resid)) +
  geom_freqpoly(binwidth = .5)
# This helps you to calibrate the quality of the model: how far away are the predictions from
# the observed values? Note that the average of the residual will always be 0.

# You'll often want to re-create plots using the residuals instead of the original predictor. 
ggplot(sim1, aes(x, resid)) +
  geom_ref_line(h = 0) +
  geom_point()
# The plot suggests that the residuals are random noise (chance), suggesting that our model
# has done a good job of capturing the patterns in the datatset.


# Formulas & Model Families -----------------------------------------------

# If you want to see what R actually does, over and above using x ~ y, you can use the
# model_matrix() function. It takes a data frame and a formula and returns a tibble that 
# defines the model equation: each column in the output is associated with one coefficient
# in the model, and the function is always y = a_1 * out1 + a_2*out_2. For the simplest case
# of y ~ x1, this shows us something interesting:
df <- tribble(
  ~ y, ~ x1, ~ x2,
    4,    2,    5,
    5,    1,    6
)
model_matrix(df, y ~ x1)
# The way that R adds the intercept to the model is just by having a column that is full of 
# ones, By default, R will always add this column. If you don't want that, you need to 
# explicitly drop it with -1:
model_matrix(df, y ~ x1 - 1)
# The model matrix grows in an unsurprising way when you add more variables to the model:
model_matrix(df, y ~ x1 + x2)
# This formula notation is sometimes called Wilkinson-Rogers notation.


#  Categorical Variables --------------------------------------------------

# You can't multiply categories, so therefore you need to convert it to y = 0_x + x_1 * sex_m
# where sex_m is equal to 1 and the other outcome is zero.

# Here's the sim2 dataset from modelr:
ggplot(sim2)  +
  geom_point(aes(y = y, x = x))
# We can fit a model to it, and generate predictions:
model2 <- lm(y ~ x, data = sim2)

grid <- sim2 %>% 
  data_grid(x) %>% 
  add_predictions(model2)
grid
# Effectively, a model with a categorical x will predict the mean value for each category.
# Because the mean minimizes the root-mean-sqaured distance. This is easily visualised if
# we overlay the predictions on top pf the original data:
ggplot(sim2, aes(x)) +
  geom_point(aes(y = y)) +
  geom_point(
    data = grid, aes(y = pred),
    colour = "red",
    size = 4
  )
# You can't make predictions about levels that you didn't observe. Sometimes you'll do this
# by accident so it's good to recognise this error message:
tibble(x = "e") %>% 
  add_predictions(model2)


# Interactions (Continuous & Categorical) ---------------------------------

# What happens when you combine a continuous and categorical variable? We can visualise it 
# with a simple plot:
ggplot(sim3, aes(y = y, x = x1)) +
  geom_point(aes(colour = x2))

# There are two possible models that you could fit to this data:
mod1 <- lm(y ~ x1 + x2, data = sim3)
mod2 <- lm(y ~ x1 * x2, data = sim3)

# When you add variables with +, it is additive, and therefore the model will estimate each 
# effect independent of all the others. It's possible to fit the so-called interaction by
# using *. For example, y ~ x1 * x2. Note, that whenever you use *, both the interaction and
# the individual components are included in the model.

# To visualise these models we need two new tricks:
#   1. We have two predictors, so we need to give data_grid() both variables. It finds all the 
#   unique values of x1 & x2 and then generates all combinations.

#   2. To generate predictions from both models simultaneously, we can use gather_predictions()
#   which adds each prediction as a row. The complement of gather_predictions() is 
#   spread_predictions(), which adds each prediction to a new column.

# Together this gives us:
grid <- sim3 %>% 
  data_grid(x1, x2) %>% 
  gather_predictions(mod1, mod2)
grid

# We can visualise the results for both models on one plot using faceting:
ggplot(sim3, aes(y = y, x = x1, colour = x2)) +
  geom_point() +
  geom_line(data = grid, aes(y = pred)) +
  facet_wrap(~ model)
# Note that the model that yses + has the same slope for each line, but different intercepts.
# The model that uses * has a different slope and intercept for each line.

# Which model is better for this data? We can take a look at the residuals. We can also facet
# by both model and x2 because it makes it easier to see the pattern within each group:
sim3 <- sim3 %>% 
  gather_residuals(mod1, mod2)

ggplot(sim3, aes(x1, resid, colour = x2)) +
  geom_point() +
  facet_grid(model ~ x2)

# The residuals for mod1 show that the model has clearly missed some pattern in b, and less so, 
# but still present, is pattern in c, and d. 


# Interactions (Two Continuous) -------------------------------------------

# Initially, things proceed almost indentically to the previous example:
mod1 <- lm(y ~ x1 + x2, data = sim4)
mod2 <- lm(y ~ x1 * x2, data = sim4)

grid <- sim4 %>% 
  data_grid(
    x1 = seq_range(x1, 5),
    x2 = seq_range(x2, 5)
  ) %>% 
  gather_predictions(mod1, mod2)
grid

# However, note the use of seq_range() inside data_grid(). Instead of using every unqiue value
# of x, you can use a regularly spaced grid of five values between the minimum and maximum
# numbers. It's probably not important here, but it is a useful technique in general. There
# are three other useful arguments to seq_range():

# pretty = TRUE will generate a 'pretty' sequence, i.e. something that looks nice to the 
# human eye. This is useful if you want to produce tables of outputs:

seq_range(c(.0123, .923423), n = 5)
# versus...
seq_range(c(.0123, .923423), n = 5, pretty = TRUE)

# trim = .1 or any other value, will trim off 10% of the tail values. This is useful if the 
# variable has a long-tailed distribution and you want to focus on generating values near
# the center:
x1 <- rcauchy(100)
seq_range(x1, n = 5)
# versus...
seq_range(x1, n = 5, trim = .1)
seq_range(x1, n = 5, trim = .25)
seq_range(x1, n = 5, trim = .5)

# exapnd = .1 us the some sense the opposite of trim(); it expands the range by 10%:
x2 <- c(0, 1)
seq_range(x2, n = 5)
# versus...
seq_range(x2, n = 5, expand = .1)
seq_range(x2, n = 5, expand = .25)
seq_range(x2, n = 5, expand = .5)

# Next, try visualise that model. We have to continuos predictors, so you can imagine the 
# model like a 3D surface. We could visualise this using geom-tile():
ggplot(grid, aes(x1, x2)) +
  geom_tile(aes(fill = pred)) +
  facet_wrap(~ model)
# It doesn't suggest that the models are very different. But that's partly an illusion: our
# eyes and brains are not very good at accurately comparing shades of colour. Instead of 
# looking at ut from the top, we could look at it from either side, showing multiple slices;

ggplot(grid, aes(x1, pred, colour = x2, group = x2)) +
  geom_line() +
  facet_wrap(~ model)

ggplot(grid, aes(x2, pred, colour = x1, group = x1)) +
  geom_line() +
  facet_wrap(~ model)
# This shows you that the interaction between two continuous variables works basically the 
# same way as for a categorical and continuous variable. An interaction says that there's not
# a fixed offset: you need to consider both values of x1 & x2 simultaneously in order to 
# predict y.

# You can see that even with just two continuous variables, using good visualisations.


# Transformations ---------------------------------------------------------

# You can also perform transformations inside the model formula. For example:

# log(y) ~ sqrt(x1) + x2 is trasnformed to y = a_1 * a_2 * x1 * sqrt(x) + a3 * x2. If your
# transformation contains +, *, ^, or -, you need to wrap it up in I() so R doesn't treat it
# like part of the model specfication. For example, y ~ x + I(x ^ 2) is translated to
# y = a_1 + a_2 + a_3 * x^2. If you forget I() and specify y ~ x ^ 2 + x specifies the 
#  function y = a_1 + a_2 * x. That's probably not what you intended! 

# Again, if you get confused about what your model is doing, you can always use model_matrix()
# to see exactly what equation lm() is fitting:
df <- tribble(
  ~ y, ~ x,
    1,   1,
    2,   2, 
    3,   3
)
model_matrix(df, y ~ x^2 + x)

model_matrix(df, y ~ I(x^2) + x)

# Transformations are useful becayse you can use them to approximate nonlinear functions.
#  Taylor's theorem states that you can approximate any smooth function with an infinite sum
# of polynomials. That means you can use a linear function to get arbitrarily close to a 
# smooth functuon by fitting an equation like y = a_1 + a_2 * x + a_3 * x^2 + a)4 * x^3.
# Typing that sequence by hand is tedious, so R provides a helper function, poly():
model_matrix(df, y ~ poly(x, 2))

# However, there is one major problem wiuth using poly(): outside the range of the data, 
# polynomials rapidly shoot off to positive or negative infinity. One safer alternative is to
# use the natural spline, splines::ns():
library(splines)
model_matrix(df, y ~ ns(x, 2))

# Let's see what it looks like when we try to approximate a non-linear function:
sim5 <- tibble(
  x = seq(0, 3.5 * pi, length = 50),
  y = 4 * sin(x) + rnorm(length(x))
)

ggplot(sim5, aes(y = y, x = x)) +
  geom_point()

# Let's try fit 5 models to this data:
mod1 <- lm(y ~ ns(x, 1), data = sim5)
mod2 <- lm(y ~ ns(x, 2), data = sim5)
mod3 <- lm(y ~ ns(x, 3), data = sim5)
mod4 <- lm(y ~ ns(x, 4), data = sim5)
mod5 <- lm(y ~ ns(x, 5), data = sim5)

grid <- sim5 %>% 
data_grid(x = seq_range(x, n = 50, expand = 0.1)) %>% 
  gather_predictions(mod1, mod2, mod3, mod4, mod5, .pred = "y")

ggplot(sim5, aes(y = y, x = x)) +
  geom_point() +
  geom_line(data = grid, colour = "red") +
  facet_wrap(~ model)

# Notice that the extrapolation outside of the range of the data is clearly bad. This is the
# downside to approximating a function with a polynomial. But this is a very real problem 
# with model: the model can never tell you if the behaviour is true when you start 
# extrapolating outside the range of the data that you have seen. You must rely on theory 
# and science.


# Missing values in Models ------------------------------------------------

# you can set na.action = na.warn if you want to know if any NA values have been dropped
# silently.

# Further, you can suppress the warning with na.action = na.exclude

# You can always see exactly the number of observations were used with nobs()


# Chapter 19: Model Building ----------------------------------------------

library(tidyverse)
library(modelr)
options(na.action = na.warn)

library(nycflights13)
library(lubridate)


# Why Are Low-Quality Diamonds More Expensive? ----------------------------

ggplot(diamonds, aes(cut, price)) +
  geom_boxplot()
ggplot(diamonds, aes(color, price)) +
  geom_boxplot()
ggplot(diamonds, aes(clarity, price)) +
  geom_boxplot()

# It looks like lower-quality diamonds have higher prices because there is an important 
# confounding variable: the weight (carat) of the diamond. The weight of the diamond is the 
# single most important factor for determining the price of the diamond, and lower-quality
# diamonds tends to be larger:
ggplot(diamonds, aes(carat, price)) +
  geom_hex(bins = 50)

# We can make it easier to see how the other attrubutes of a diamond affect its relative price
# by fitting a model to seperate out the effect of carat. First, let's make a couple of tweaks
# to the diamonds dataset to make it easier to work with:

#   1. Focus on diamonds smaller than 2.5 carats (99.7% of the data)
#   2. Log-transform the carat and price variables

diamonds2 <- diamonds %>% 
  filter(carat <= 2.5) %>% 
  mutate(lprice = log2(price), lcarat = log2(carat))
# Together, these changes make it easier to see the relationship between carat and price:
ggplot(diamonds2, aes(lcarat, lprice)) +
  geom_hex(bins = 50)
# The log transformation is particularly useful here because it makes the pattern linear, and
# linear patterns are the easiest to work with. Let's take the next step & remove that strong
# linear pattern. We first make the pattern explicit by fitting a model:
mod_diamond <- lm(lprice ~ lcarat, data = diamonds2)
# Then we look at what the model tells us about the data. Note that here, we back-transform
# the predictions, undoing the log transformation, so we can overlay the predicitions on the
# raw data:
grid <- diamonds2 %>% 
  data_grid(carat = seq_range(carat, 20)) %>% 
  mutate(lcarat = log2(carat)) %>% 
  add_predictions(mod_diamond, "lprice") %>% 
  mutate(price = 2 ^ lprice)

ggplot(diamonds2, aes(carat, price)) +
  geom_hex(bins = 50) +
  geom_line(data = grid, colour = "red", size = 1)

# That tells us something interesting about our data. If we believe our model, then the large
# diamonds are much cheaper than expected. This is probably because no diamond in this dataset
# costs more than $19,000.

# Now we can look at the residuals, which verifies that we've successfully removed the strong
# linear pattern:
diamonds2 <- diamonds2 %>% 
  add_residuals(mod_diamond, "lresid")

ggplot(diamonds2, aes(lcarat, lresid)) +
  geom_hex(bins = 50)

# Importantly, we can now redo our motivating plots using those residuals instead of price:
ggplot(diamonds2, aes(cut, lresid)) +
  geom_boxplot()
ggplot(diamonds2, aes(cut, lresid)) +
  geom_boxplot()
ggplot(diamonds2, aes(clarity, lresid)) +
  geom_boxplot()
# Now we see the relationship we expect: as the quality of the diamond increases, so to does 
# its relative price. To interpret the y-axis, we need to think about what the residuals are
# are telling us, and what scale they are on. A residual of -1 indicates that lprice was 1
# unit lower than a prediction based solely on its weight. 2^-1 is 1/2, and so points with a
# value of -1 are half the expected price, and residuals with value 1 are twice the predicted
# price.


# A More Complicated Model ------------------------------------------------

# If we wanted to, we could continue to build up our model, moving the effects we've observed
# into the model to make them explicit. For example, we could include colour, cut, and clarity
# into the model so that we also make explicit the effect of these three categorical variables
mod_diamond2 <- lm(
  lprice ~ lcarat + color + cut + clarity, data = diamonds2
)
summary(mod_diamond2)

# This model now includes four predictor, so it's getting harder to visualise. Fortunately, 
# they are all currently independent, which means we can plot them invividually in four plots.
# To make the process a little easier, we're going to use the .model argument to data_grid():
grid <- diamonds2 %>% 
  data_grid(cut, .model = mod_diamond2) %>% 
  add_predictions(mod_diamond2)
grid

ggplot(grid, aes(cut, pred)) +
  geom_point()

# If the model needs variables that you haven't explicitly supplied, data_grid() will 
# automatically fill them in with the typical value. For continuous variables, it uses the
# median, and for categorical variables it uses the most common value (mode):
diamonds2 <- diamonds2 %>% 
  add_residuals(mod_diamond2, "lresid2")

ggplot(diamonds2, aes(lcarat, lresid2)) +
  geom_hex(bins = 50)

# This plot indicates that there are some diamonds with quite large residuals. It is often 
# useful to slueth unusual values individually:
diamonds2 %>% 
filter(abs(lresid2) > 1) %>% 
  add_predictions(mod_diamond2) %>% 
  mutate(pred = round(2 ^ pred)) %>% 
  select(price, pred, carat:table, x:z) %>% 
  arrange(price)
# Nothing really jumps out here, but it is probably worth spending time considering this 
# indicates a problem with the model, or if there are errors in the data. If there are 
# mistakes in the data, this could be an oppurtunity to buy diamonds that have been priced 
# low incorrectly.


# What Affects the Number of Daily Flights? -------------------------------

daily <- flights %>% 
  mutate(date = make_date(year, month, day)) %>% 
  group_by(date) %>% 
  summarise(n = n())
daily

ggplot(daily, aes(date, n)) +
  geom_line()

# Understanding the long-term trend is challenging because there's a very strong day-of-the-
# week effect that dominates the subtler patterns. Let us start by looking at the distribution
# of flight numbers by day of week:
daily <- daily %>% 
  mutate(wday = wday(date, label = TRUE))
ggplot(daily, aes(wday, n)) +
  geom_boxplot()

# There are fewer flights on weekends because most treavel is for business. The effect is
# particularly telling on Sunday: you might sometimes leave on Sunday for a Monday meeting, 
# but it's very rare that you'd leave on Saturday.

# One way to remove this strong pattern is to use a model. First, we fit the model, and
# display its predictions overlaid on the original data:
mod1_flights <- lm(n ~ wday, data = daily)

grid <- daily %>% 
  data_grid(wday) %>% 
  add_predictions(mod1_flights, "n")

ggplot(daily, aes(wday, n)) +
  geom_boxplot() +
  geom_point(data = grid, colour = "red", size = 4)

# Next we compute & visualise the residuals:
daily <- daily %>% 
  add_residuals(mod1_flights)

daily %>% 
  ggplot(aes(date, resid)) +
  geom_ref_line(h = 0) +
  geom_line()

# Note the change in the y-axis: now we are seeing the deviation from the expected number of
# flights, given the day of the week. This plot is useful because now that we've removed much
# of the large day-of-the-week effect, we can see some of the subtler patterns that remain:

#   Our model seems to fail starting in June; you can still see a strong, regular pattern that
#   our model hasn't captured. Drawing a plot with one line for each day of the week makes the
#   easier to see...
ggplot(daily, aes(date, resid, colour = wday)) +
  geom_ref_line(h = 0) +
  geom_line()
# Our model fails to accurately predict the number of dlights on Saturday; during the summer
# there are more flights than we expect, and during fall there are fewer.

# There are some days with far fewer flights than expected:
daily %>% 
  filter(resid < -100)
# It seems these days correspond with national holidays in the USA.

# However, there seems to be some smoother long-term trend over the course of a year. We can 
# highlight that trend with geom_smooth():
daily %>% 
  ggplot(aes(date, resid)) +
  geom_ref_line(h = 0) +
  geom_line(colour = "grey50") +
  geom_smooth(se = FALSE, span = .20)
# There are fewer flights in Jan and Dec, and more in summer (May-Sep). We can't do much with
# this pattern quantitatively, because we only have a single year of data. But we can use our
# domain knowledge to brainstorm potential explainations.


# Seasonal Saturday Effect ------------------------------------------------

# Let's first tacjle our failure to accurately predict the number of flights on Saturday. A
# good place to start is to go back to the raw numbers, focusing on Saturdays:
daily %>% 
  filter(wday == "Sat") %>% 
  ggplot(aes(date, n)) +
  geom_point() +
  geom_line() +
  scale_x_date(
    NULL,
    date_breaks = "1 month",
    date_labels = "%b"
  )

# Let's hypothesise that the pattern is caused by summer holidays. Why are there more Saturday
# flights in the spring than in the fall?

# Let's create a 'term' variable that roughly captures the three school terms, and check our
# work with a plot:
terms <- function(date) {
  cut(date,
      breaks = ymd(20130101, 20130605, 20130825, 20140101),
      labels = c("spring", "summer", "fall")
      )
}

daily <- daily %>% 
  mutate(term = terms(date))

daily %>% 
  filter(wday == "Sat") %>% 
  ggplot(aes(date, n, colour = term)) +
  geom_point(alpha = 1/3) +
  geom_line() +
  scale_x_date(
    NULL,
    date_breaks = "1 month",
    date_labels = "%b"
  )

# It's useful to see how this new variable affects the other days of the week:
daily %>% 
  ggplot(aes(wday, n, colour = term)) +
  geom_boxplot()
# It looks like there is significant variation acriss the terms, so fitting a seperate 
# day-of-week effect for each term is reasonable. This improves our model, but not as much as
# we might hope:
mod1 <- lm(n ~ wday, data = daily)
mod2 <- lm(n ~ wday * term, data = daily)

daily %>% 
  gather_residuals(without_term = mod1, with_term = mod2) %>% 
  ggplot(aes(date, resid, colour = model)) +
  geom_line(alpha = .75)
# We can now see the problem bu overlaying the predicitons from the model onto the raw data:
grid <- daily %>% 
  data_grid(wday, term) %>% 
  add_predictions(mod2, "n")

ggplot(daily, aes(wday, n)) +
  geom_boxplot() +
  geom_point(data = grid, colour = "red") +
  facet_wrap(~ term)
# Our model is finding the mean effect, but we have a lof of outliers, so the mean tends to be
# far away from the typical value. We can alleviate this problem by using a Robust Linear
# Model, which reduces the effect of outliers on our estimates, and gives a model that does a
# good job of removing the day-of-week problem pattern:
library(MASS)

mod3 <- rlm(n ~ wday * term, data = daily)

daily %>% 
  add_residuals(mod3, "resid") %>% 
  ggplot(aes(date, resid)) +
  geom_hline(yintercept = 0, size = 2, colour = "white") +
  geom_line()


# Computed Variables ------------------------------------------------------

# If you're experimenting with many models and many visualisations, it's a good idea to bundle
# the creation of variables up into a function so there's no chance of accidently applying a
# different transformation in different places. For example, we could write:
compute_vars <- function(data) {
  data %>% 
    mutate(
      term = term(date),
      wday = wday(date, label = TRUE)
    )
}

# Another option is to put transformations direclty in the model formula;
wday2 <- function(x) wday(x, label = TRUE)
mod3 <- lm(n ~ wday2(date) * terms(date), data = daily)

# Either of the above methods are reasonable. Making the transformed variable explicit is
# useful if you want to check your work, or use them in a visualisation. But you can't easily
# use transformations (like splines) that return multiple columns. Including the transforma - 
# tion in the model function makes life a little easier when you're working with many 
# different datasets because the model is self-contained.


# Time of Year: An Alternative Approach -----------------------------------

# In the previous example, we used domain knowledge to slueth the data. An alternative to 
# making our knowledge explicit in the model is to give the data more room to speak. We could
# use a more flexible model and allow that to capture the pattern we're interested in. A 
# simple linear trend isn't adequate, so we could try using a natural spline to fit a smooth
# curve across the year:
library(splines)
mod <- rlm(n ~ wday * ns(date, 5), data = daily)

daily %>% 
  data_grid(wday, date = seq_range(date, n = 13)) %>% 
  add_predictions(mod) %>% 
  ggplot(aes(date, pred, colour = wday)) +
  geom_line() +
  geom_point()
# We see a strong pattern in the numbers of Saturday flights. This is reassuring, because we
# also saw that pattern in the raw data. It's a good sign when you get the same signal from
# different approaches.


# Chapter 20: Many Models with purr & broom -------------------------------

library(gapminder)
gapminder

# In this case study, we're going to focus on just three variables to answer the question, 
# "How does life expectancy (lifeExp) change over time (year) for each country (country)? A
# good place to start is with a plot:
gapminder %>% 
  ggplot(aes(year, lifeExp, group = country)) +
  geom_line(alpha = 1/3)
# This is a small dataset; it only has ~ 1,700 obs and 3 variables. But it is still hard to 
# see what's going on! Overall, it looks like lifeExp has been steadily improving. However,
# if you look closely, you migjt notice some countries that don't follow this pattern. How
# can we make those countries easier to see?

# One way is to use the same approach as last chapter; there's a strong singal (overall linear
# growth) that makes it hard to see subtler trends. We'll tease these factors apart by fitting
# a model with a linear trend. The model captures steady growth over time, and the residuals
# will show what's left:
nz <- filter(gapminder, country == "New Zealand")
nz %>% 
  ggplot(aes(year, lifeExp)) +
  geom_line() +
  ggtitle("Full data = ")

nz_mod <- lm(lifeExp ~ year, data = nz)

nz %>% 
  add_predictions(nz_mod) %>% 
  ggplot(aes(year, pred)) +
  geom_line() +
  ggtitle("Linear trend + ")

nz %>% 
  add_residuals(nz_mod) %>% 
  ggplot(aes(year, resid)) +
  geom_hline(yintercept = 0, colour = "white", size = 3) +
  geom_line() +
  ggtitle("Remaining pattern")

# How can we easily fit this model to every country?


# Nested Data -------------------------------------------------------------

# We can extract out the common code with a function and repeat using a map function from 
# purr. This problem is structured a little differently to what we've done so far. Instead of
# repeating an action for each variable, we want to repeat an action for each country; a sub-
# set of rows. To do that, we need a new data structure: the nested data frame. To create a 
# nested data frame, we start with a grouped data frame, and 'nest' it:
by_country <- gapminder %>% 
  group_by(country, continent) %>% 
  nest()

by_country

# This creates a data frame that has one row per group (in this case country), and a rather
# unusual column: data.data is a list of data frame (or tibbles to be precise).

# The data column is a little tricky to look at because it's a moderately complicated list.
# If you pluck out a single element from the data column you'll see that it contains all the
# data for the named country:
by_country$data[1]

# Therefore, in a standard grouped data frame, each row is an observation; in a nested data
# data frame, each row is a group. Another way to think about a nested dataset is we now
# have a meta-observation: a row that represents the complete time course for a country, 
# rahter than a single point in time.


# List-Columns ------------------------------------------------------------

# Here is a model fitting function:
country_model <- function(df) {
  lm(lifeExp ~ year, data = df)
}
# And we want to apply it to every data frame. The data frames are in a list, so we can use
# ourr::map() to apply to country_model to each element:
models <- map(by_country$data, country_model)

# However, rather than leaving the list of models as a free-floating object, I think it's
# better to store it as a column in the by_country data frame. Storing related objects in 
# columns is a key part of the value of data frames, and why list-columns are such a good
# idea. For example, in working with this case study, we are going to have lots of lists
# where we have one element per country. So why not store them all together in one data frame?

# In other words, instead of creating a new object in the global environment, we're going to
# create a new variable in the by_country data frame. That's a job for dplyr::mutate():

by_country <- by_country %>% 
  mutate(model = map(data, country_model))
by_country

# This has a big advantage because all the related objects are stored together, you don't need
# to manually keep them in sync when you filter or arrange. The semantics of the data frame
# takes care of that for you:
by_country %>% 
  filter(continent == "Europe")

by_country %>% 
  arrange(continent, country)

# If your list of data frames and list of models were seperate objects, you have to remember
# that whenever you reorder or subset one vector, you need to reorder or subset all the others
# in order to keep them in sync. If you forget, your code will continue to work, but it will
# give the wrong answer.


# Unnesting ---------------------------------------------------------------

# Previously, we computed the residuals of a single model with a single dataset. Now we have
# 142 data frames and 142 models. To compute the residuals, we need to call add_residuals()
# with each data pair:

by_country <- by_country %>% 
  mutate(
    resids = map2(data, model, add_residuals)
  )
by_country
# But how can you plot a list of data frames? Instead of struggling to answer that question, 
# let's turn the list of data frames back into a regular data frame. Previously we used nest()
# to turn a regular data frame into a nested data frame, and now we do the opposite with 
# unnest():
resids <- unnest(by_country, resids)
resids

# Note that each regular column is repeated once for each row in the nested column.

# Now that we have a regular data frame, we can plot the residuals:
resids %>% 
  ggplot(aes(year, resid)) +
  geom_line(aes(group = country), alpha = 1/3) +
  geom_smooth(se = FALSE)
# Faceting by continent is particulary revealing:
resids %>% 
  ggplot(aes(year, resid, group = country)) +
  geom_line(alpha = 1/3) +
  facet_wrap(~ continent)

# It looks like we've missed some mild pattern. There's also something interesting going on in
# Africa: we some very large residuals which suggests that our model isn't fitting so well 
# there. 


# Model Quality -----------------------------------------------------------

# Instead of looking at the residuals from the model, we could look at some general measureme-
# nts of model quality. The broom package provides a general set of functions to turn models
# into tidy data. Here, we'll use the broom::glance() to extract some mode quality metrics. 
# If we apply it to a model, we get a data frame with a single row:
library(broom)
glance(nz_mod)

# We can use mutate and unnest to create a data frame with a row for each country:
by_country %>% 
  mutate(glance = map(model, glance)) %>% 
  unnest(glance)

# This isn't quite the output we want, because it includes all the list columns. This is 
# default behaviour when unnest() works on single-row data frames. To suppress columns, we use
# .drop = TRUE:
glance <- by_country %>% 
  mutate(glance = map(model, glance)) %>% 
  unnest(glance, .drop = TRUE)
glance

# With this data in hand, we can look for models that don't fit well:
glance %>% 
  arrange(r.squared)
# The worst models all appear to be in Africa. Let's double-check that with a plot. Here we
# have a relatively small number of observations and a discrete variable, so geom_jitter() is
# effective:
glance %>% 
  ggplot(aes(continent, r.squared)) +
  geom_jitter(width = .5)
# We could pull out the countries with particularly bad r.squared and plot the data:
bad_fit <- filter(glance, r.squared < .25)

gapminder %>% 
  semi_join(bad_fit, by = "country") %>% 
  ggplot(aes(year, lifeExp, colour = country)) +
  geom_line() +
  ggrepel::geom_label_repel(
    aes(label = country),
    data = resids
  )
# We see two main effects here: the tragedies of the HIV/AIDS epidemic & the Rwandan genocide.


# The easiest way to make a list column is with tribble():
tribble(
  ~ x, ~ y,
  1:3, "1, 2", 
  3:5, "3, 4, 5"
)
# List-columns are often most useful as an intermediate data structure. They're hard to work
# with directly, because most R functions work with atomic vectors or data frames, but the 
# advantage of keeping related items together in a data frame is worth a little hassle.

# Read further for specifics of nesting and unnesting atomic vectors, columns and summaries.

# ===================================END===============================