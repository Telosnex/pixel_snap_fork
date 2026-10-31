import 'package:flutter/widgets.dart';

class GeneratePixelSnap<T> {
  const GeneratePixelSnap();
}

class GeneratePixelSnapFork<T> {
  const GeneratePixelSnapFork();
}

class GeneratePixelSnapSubclass<T> {
  const GeneratePixelSnapSubclass();
}

// Feeds widget generation.
@GeneratePixelSnap<Align>()
@GeneratePixelSnap<Baseline>()
@GeneratePixelSnap<ConstrainedBox>()
@GeneratePixelSnap<DecoratedBox>()
@GeneratePixelSnap<Container>()
@GeneratePixelSnap<IntrinsicWidth>()
@GeneratePixelSnap<LimitedBox>()
@GeneratePixelSnap<OverflowBox>()
@GeneratePixelSnap<Padding>()
@GeneratePixelSnap<SizedBox>()
@GeneratePixelSnap<SizedOverflowBox>()
@GeneratePixelSnap<Positioned>()
@GeneratePixelSnap<PhysicalModel>()
@GeneratePixelSnap<CustomPaint>()
@GeneratePixelSnap<Icon>()
@GeneratePixelSnap<ImageIcon>()
@GeneratePixelSnap<AnimatedAlign>()
@GeneratePixelSnap<AnimatedContainer>()
@GeneratePixelSnap<AnimatedCrossFade>()
@GeneratePixelSnap<AnimatedPositioned>()
@GeneratePixelSnap<AnimatedPadding>()
@GeneratePixelSnap<AnimatedPhysicalModel>()
@GeneratePixelSnap<AnimatedSize>()
@GeneratePixelSnapFork<Flex>()
@GeneratePixelSnapFork<Row>()
@GeneratePixelSnapFork<Column>()
@GeneratePixelSnapFork<FractionallySizedBox>()
@GeneratePixelSnapFork<Center>()
@GeneratePixelSnapSubclass<Text>()
@GeneratePixelSnapSubclass<RichText>()
@GeneratePixelSnapFork<FittedBox>()
@GeneratePixelSnapFork<Image>()
void generate() {}
