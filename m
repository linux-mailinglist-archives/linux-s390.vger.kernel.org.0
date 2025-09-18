Return-Path: <linux-s390+bounces-12280-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2299BB36B0D
	for <lists+linux-s390@lfdr.de>; Tue, 26 Aug 2025 16:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E5474E2ED4
	for <lists+linux-s390@lfdr.de>; Tue, 26 Aug 2025 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1730C2367D9;
	Tue, 26 Aug 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPPzaKa9"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81780352FF5
	for <linux-s390@vger.kernel.org>; Tue, 26 Aug 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219176; cv=none; b=udteXidUZQ7Mm53f/oplTTjFm35yU8zw5TFri2o4PxekSp131Px84uEdtizPWdGkceBkiLIsC+3FsdWw2Th+CSmw9P31Q4iGTrEDF0+HB/ma1IelWeB2CS5dMrivHn5wihhE7vfHYIvV9dg33cr2RV4dzwAdMQusxaZE+1MtTyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219176; c=relaxed/simple;
	bh=26LrYUdrz/oWJs7z44qFoboSutOWdrv5ex2QJktczqQ=;
	h=Message-ID:Date:From:To:Cc:Subject; b=LsruhZxVgc8zjpik2ZUBDKpPhAMkhuPtMdX/lGWN1TzIRiuuI5nafQSxaSJNXNJA30fr8j+TJFd0nzbs4nRH72h9S3rCGeBf3mh0ZyHfqELSGkAv+oOrCk8wzjtB6qD4TeCvbwNO+CSicD528r1hlG76lCXZIhY7iSJ0oK6/eq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPPzaKa9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756219173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=26LrYUdrz/oWJs7z44qFoboSutOWdrv5ex2QJktczqQ=;
	b=dPPzaKa9HSCXcLIfPbJFRAZQCj0Rt+WoJ0QfJcJA8wLrkg8h3BG7I1SFyUMUYpLvNmolQo
	wNfdojF/09vWwLjmTUNemfIL6nc7y8tHclvccNubb7owQcX8+BllannkqeYxvUvR8y1+TL
	VhyRV3bdvfZCkfQkycjwq6DoeCOHMzs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-GzEMV1G1PVWigTYpvp9xbw-1; Tue,
 26 Aug 2025 10:39:30 -0400
X-MC-Unique: GzEMV1G1PVWigTYpvp9xbw-1
X-Mimecast-MFC-AGG-ID: GzEMV1G1PVWigTYpvp9xbw_1756219169
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CEF31800370;
	Tue, 26 Aug 2025 14:39:28 +0000 (UTC)
Received: from debian4.vm (unknown [10.22.80.227])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8ADAA18004A3;
	Tue, 26 Aug 2025 14:39:24 +0000 (UTC)
Received: by debian4.vm (sSMTP sendmail emulation); Tue, 26 Aug 2025 16:39:22 +0200
Message-ID: <20250826143646.570314717@debian4.vm>
User-Agent: quilt/0.68
Date: Tue, 26 Aug 2025 16:36:46 +0200
From: Mikulas Patocka <mpatocka@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Biggers <ebiggers@kernel.org>,
 dengler@linux.ibm.com,
 linux-s390@vger.kernel.org,
 dm-devel@lists.linux.dev,
 ifranzki@linux.ibm.com,
 agk@redhat.com,
 snitzer@kernel.org,
 gmazyland@gmail.com
Subject: [PATCH 0/7] dm-integrity asynchronous hash patches
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Hi

Here I'm sending the first version of the new dm-integrity asynchronous
hash patches.

The patches prefer the asynchronous hash interface over the synchronous
hash interface - it is for testing and it will be changed in the final
release.

Mikulas


