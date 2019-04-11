library(magick)
library(ggforce)
library(tidyverse)

base <- ggplot() +
  xlim(0, 1) +
  ylim(0, 1) +
  labs(x = '', y = '') +
  coord_fixed() +
  theme_void()

elements <- c(
  geom_line(aes(x = c(.1, .675), y = c(.8, .8)), linetype = 'dashed'),
  geom_line(aes(x = c(.675, .22), y = c(.8, .208)), linetype = 'dashed'),
  geom_line(aes(x = c(.919, .675), y = c(.126, .8)), linetype = 'dashed'),
  geom_circle(aes(x0 = .1, y0 = .8, r = .1)),
  geom_circle(aes(x0 = .25, y0 = .8, r = .1)),
  geom_circle(aes(x0 = .675, y0 = .8, r = .1)),
  geom_circle(aes(x0 = .22, y0 = .208, r = .05)),
  geom_circle(aes(x0 = .55, y0 = .55, r = .05)),
  geom_circle(aes(x0 = .45, y0 = .445, r = .06)),
  geom_circle(aes(x0 = .44, y0 = .313, r = .07)),
  geom_circle(aes(x0 = .919, y0 = .126, r = .06)),
  geom_circle(aes(x0 = .1, y0 = .8, r = .1)),
  geom_circle(aes(x0 = .42, y0 = .77, r = .03)),
  geom_circle(aes(x0 = .25, y0 = .8, r = .1)),
  geom_circle(aes(x0 = .675, y0 = .8, r = .1)),
  geom_circle(aes(x0 = .42, y0 = .77, r = .03)),
  geom_circle(aes(x0 = .22, y0 = .208, r = .05)),
  geom_point(aes(x = .1, y = .9)),
  geom_point(aes(x = .1, y = .7)),
  geom_point(aes(x = .25, y = .7)),
  geom_point(aes(x = .3, y = .715)),
  geom_point(aes(x = .405, y = .8)),
  geom_point(aes(x = .45, y = .76)),
  geom_point(aes(x = .675, y = .9)),
  geom_point(aes(x = .77, y = .83)),
  geom_point(aes(x = .175, y = .23)),
  geom_point(aes(x = .265, y = .185)),
  geom_point(aes(x = .973, y = .16)),
  geom_point(aes(x = .86, y = .1)),
  geom_point(aes(x = .593, y = .577)),
  geom_point(aes(x = .501, y = .54)),
  geom_point(aes(x = .447, y = .383)),
  geom_point(aes(x = .51, y = .45)),
  geom_point(aes(x = .38, y = .35)),
  geom_line(aes(x = c(.1, .675), y = c(.9, .9))),
  geom_line(aes(x = c(.1, .25), y = c(.7, .7))),
  geom_line(aes(x = c(.3, .405), y = c(.713, .8))),
  geom_line(aes(x = c(.45, .175), y = c(.76, .23))),
  geom_line(aes(x = c(.38, .265), y = c(.35, .185))),
  geom_line(aes(x = c(.77, .973), y = c(.83, .16))),
  geom_line(aes(x = c(.593, .86), y = c(.577, .1))),
  geom_line(aes(x = c(.501, .51), y = c(.54, .45))),
  geom_curve(aes(x = .1, y = .9, xend = .1, yend = .7), curvature = pi/3),
  geom_curve(aes(x = .25, y = .7, xend = .3, yend = .715), curvature = pi/16),
  geom_curve(aes(x = .405, y = .8, xend = .45, yend = .76), curvature = -pi/5),
  geom_curve(aes(x = .675, y = .9, xend = .77, yend = .83), curvature = -pi/9),
  geom_curve(aes(x = .175, y = .23, xend = .265, yend = .185), curvature = pi/3.1),
  geom_curve(aes(x = .593, y = .577, xend = .501, yend = .54), curvature = pi/3.7),
  geom_curve(aes(x = .447, y = .383, xend = .51, yend = .45), curvature = pi/6.5),
  geom_curve(aes(x = .447, y = .383, xend = .38, yend = .35), curvature = pi/10),
  geom_curve(aes(x = .973, y = .16, xend = .86, yend = .1), curvature = -pi/3)
)

frames <- map(1:30, function(x) {
  g <- base + 
    elements[sample(1:length(elements), sample(10:length(elements), 1))] 
  
  ggsave(g, filename = str_glue('img/frame_{x}.png'), width = 4, height = 4)
  image_read(str_glue('img/frame_{x}.png'))
})

image_animate(image_join(frames), fps = 10, loop = 0)
