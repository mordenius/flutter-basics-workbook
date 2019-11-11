part of delimeals;

class MealItem extends StatelessWidget {
  final Meal meal;

  final Function removeMeal;
  MealItem(this.meal, this.removeMeal);

  void _selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(MealScreen.routeName, arguments: meal).then((result) {
      if (result == null) {
        return;
      }
      
      removeMeal(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectMeal(context);
      },
      child: Card(
        margin: const EdgeInsets.all(15),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Image.network(
                      meal.imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      width: 300,
                      color: Colors.black54,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(meal.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.right),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Row(children: [
                    Icon(
                      Icons.schedule,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text('${meal.duration} min'),
                  ]),
                  Row(children: [
                    Icon(
                      Icons.work,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text('${meal.getComplexity()}'),
                  ]),
                  Row(children: [
                    Icon(
                      Icons.attach_money,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text('${meal.getAffordability()}'),
                  ]),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
