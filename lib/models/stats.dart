class Stats {
    int numRecycled;
    int numWasted;
    int numComposted;

    Stats(this.numRecycled, this.numWasted, this.numComposted);

    Map<String, int> toMap() {
        return {
            'numRecycled': numRecycled,
            'numComposted': numComposted,
            'numWasted': numWasted
        };
    } 

    static Stats fromMap(Map<String, dynamic> map) {
        int? numRecycled = map['numRecycled'];
        int? numWasted = map['numWasted'];
        int? numComposted = map['numComposted'];

        return Stats(
          numRecycled == null ? 0 : numRecycled,
          numWasted == null ? 0 : numWasted,
          numComposted == null ? 0 : numComposted
        );
    }
}