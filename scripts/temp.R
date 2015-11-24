ggplot(filter(crime, street == "VICTORIA ST"), aes(x = Category))+ geom_bar()

head(unique(crime$Address))
filter(crime, Address == "OAK ST / LAGUNA ST")
group_by_address_category <- group_by(crime, Address, Category)
View(summarise(group_by_address, n()))


group_by_address_street <- group_by(crime, street, Category)
View(summarise(group_by_address_street, n()))

result1 <- group_by_pdDistrict_street_category <- group_by(crime, PdDistrict, street, Category)
result2 <- group_by_pdDistrict_category_street <- group_by(crime, PdDistrict, Category, street)
result3 <- group_by_pdDistrict_street <- group_by(crime, PdDistrict, street)

result4 <- group_by_pdDistrict_address_category <- group_by(crime, PdDistrict, Address, Category)
#result2 <- group_by_pdDistrict_category_street <- group_by(crime, PdDistrict, Category, street)
#result3 <- group_by_pdDistrict_street <- group_by(crime, PdDistrict, street)
View(summarise(result4, count = n(), feq = Mode(Category)))
