import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:senpass/models/ticketModel.dart';
import 'package:senpass/services/dbServices.dart';
import 'package:senpass/utilities/shared-ui/ticketFeed.dart';

class TicketList extends StatefulWidget {
  final String? pageName, userID;

  const TicketList({super.key, this.pageName, this.userID});

  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  @override
  Widget build(BuildContext context) {
    final _tickets = Provider.of<List<Ticket>>(context);
    final vw = MediaQuery.of(context).size.width;
    final isMobil = vw <= 599;
    final isTablet = vw <= 1024;
    final isDeskTop = vw > 1024;
    return SliverPadding(
      padding: isDeskTop ? EdgeInsets.symmetric(horizontal: vw * 0.1) : EdgeInsets.zero,
      sliver: SliverStaggeredGrid.countBuilder(
        crossAxisCount: isMobil
            ? 1
            : isTablet
                ? 2
                : 3,
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
        itemCount: _tickets.length,
        itemBuilder: (context, index) {
          final db = DatabaseTicketService(userID: widget.userID);
          return StreamBuilder(
            stream: db.tickets,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return TicketFeed(ticket: _tickets[index], userID: widget.userID);
                //return Container();
              } else {
                return TicketFeed(ticket: _tickets[index], userID: widget.userID);
                //return Container();
              }
            },
          );
        },
      ),
    );
  }
}
