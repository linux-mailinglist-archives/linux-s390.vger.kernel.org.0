Return-Path: <linux-s390+bounces-12271-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 952B2B36A43
	for <lists+linux-s390@lfdr.de>; Tue, 26 Aug 2025 16:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E91B1C43770
	for <lists+linux-s390@lfdr.de>; Tue, 26 Aug 2025 14:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CCA1F4C90;
	Tue, 26 Aug 2025 14:19:40 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from leontynka.twibright.com (leontynka.twibright.com [109.81.181.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1234DCDA;
	Tue, 26 Aug 2025 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.81.181.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217980; cv=none; b=osn5ffgg9v1X6o83LnFMx59OIlg0/I1lKeN7rh3fRGBJ6hM7kypbRvSyNtyMW91eREyWQCl/accD2aU0s7vxpQE2NtxLUsbEokDth+LgFXDeqppDx6wJZDrfua2CueVvOJ3A1rMA+MPW46nwiQsN0XggNg00ZHT1Xa5kes2PFFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217980; c=relaxed/simple;
	bh=26LrYUdrz/oWJs7z44qFoboSutOWdrv5ex2QJktczqQ=;
	h=Message-ID:Date:From:To:Cc:Subject; b=LbYCSR8tmP8OXrVdLT4TVX5lyi2gUE4yLF+zXDXah/vxoorC57Ak8aO14QoVIir2Gwumd6W435GoZqMe2vdAgOoNUyW+PlXZ7Yo5wvtHi3tp6NGnA8EEhcqpDgkn+ATPxFisSyMzoWO25h6OpE88/agRUNntPwk9TBiuA9+Ddds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; arc=none smtp.client-ip=109.81.181.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Received: from zen ([192.168.128.17] helo=debian.vm)
	by leontynka.twibright.com with smtp (Exim 4.96)
	(envelope-from <mpatocka@redhat.com>)
	id 1uqu9N-008VrP-0F;
	Tue, 26 Aug 2025 15:55:50 +0200
Received: by debian.vm (sSMTP sendmail emulation); Tue, 26 Aug 2025 15:55:48 +0200
Message-ID: <20250826135453.012446010@debian4.vm>
User-Agent: quilt/0.68
Date: Tue, 26 Aug 2025 15:54:53 +0200
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


