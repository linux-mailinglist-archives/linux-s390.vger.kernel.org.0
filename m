Return-Path: <linux-s390+bounces-13988-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FA7BECF67
	for <lists+linux-s390@lfdr.de>; Sat, 18 Oct 2025 14:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF8614E3897
	for <lists+linux-s390@lfdr.de>; Sat, 18 Oct 2025 12:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E652528C87C;
	Sat, 18 Oct 2025 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ti9sBBQZ"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E060354AF6
	for <linux-s390@vger.kernel.org>; Sat, 18 Oct 2025 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760789864; cv=none; b=Y/IY7j0ObKVImBTVismrwXyDifVraK4gH7u6BW2ioV0uff4JOvD5mo6RbOWSGuGymA0RDXLsxHk92Vu9ZKPVgooU1L2aY0L0DyVDRtNtbkdPElSpytMTznmeVY/JAH1Tnuh2vHzKfaOHYK/T5EZl32KQSonV0ugeWh+RQhYNGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760789864; c=relaxed/simple;
	bh=gGt73CVvuv5BT7hEaNbmyxUbjAu15wTDGJLTO48O5vg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=nXGdBzKid4tkA7BXa/tif//+ntGNXnU5nmYfOebGQMo3MyTOp2veboDQYHdel1y7EzS0hSCPix9eNqGilLUDY+o7aED318UTtBxk+gG3kKIlKAh69xbREuj78v6ChokQzm9R1PFlsTaQ7G4S/nLE/rJhAcRg9RwxKj1Klfh6TJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ti9sBBQZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760789862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlH8cS7HLtTecR83sZbVKnOJnUxVHiktjAnu92Jotug=;
	b=Ti9sBBQZDYQnbzqlE/KYKPPFWyXHuzS2VAyf8EQZlxhwpxGQyAr/po2q0rxtemK56s12ns
	VxeiCWyfWH3pZB7sefgiBNNcjHGvergrtZsZcRGa2BqdDi0opuEW0F0AtMzEtiAmv8IKvj
	hRpEnN+TUuv0c1EuteCMPZR0ov5Dd9s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-g8kbWojGPBKO4eyAIDi7jg-1; Sat,
 18 Oct 2025 08:17:36 -0400
X-MC-Unique: g8kbWojGPBKO4eyAIDi7jg-1
X-Mimecast-MFC-AGG-ID: g8kbWojGPBKO4eyAIDi7jg_1760789854
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C2D8195608A;
	Sat, 18 Oct 2025 12:17:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.57])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD5F51800353;
	Sat, 18 Oct 2025 12:17:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <395b82fc-728b-45da-afa8-c4ac8b625a45@csgroup.eu>
References: <395b82fc-728b-45da-afa8-c4ac8b625a45@csgroup.eu> <20251017144311.817771-1-dhowells@redhat.com> <20251017144311.817771-2-dhowells@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: dhowells@redhat.com, Eric Biggers <ebiggers@kernel.org>,
    "Jason A . Donenfeld" <Jason@zx2c4.com>,
    Ard Biesheuvel <ardb@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Stephan Mueller <smueller@chronox.de>,
    Lukas Wunner <lukas@wunner.de>,
    Ignat Korchagin <ignat@cloudflare.com>,
    Luis Chamberlain <mcgrof@kernel.org>,
    Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
    Sami Tolvanen <samitolvanen@google.com>,
    linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
    linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
    Harald Freudenberger <freude@linux.ibm.com>,
    Holger Dengler <dengler@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 01/17] s390/sha3: Rename conflicting functions
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Oct 2025 13:17:26 +0100
Message-ID: <937031.1760789846@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Le 17/10/2025 =C3=A0 16:42, David Howells a =C3=A9crit=C2=A0:
> > Rename the s390 sha3_* functions to have an "s390_" prefix to avoid
> > conflict with generic code.
>=20
> The functions are static, why would they conflict with generic code ?

Because of #include <crypto/sha3.h>

> Also generic code doesn't have such functions at the moment, are they add=
ed by
> a follow patch ?

Yes.  See patch 3.

David


