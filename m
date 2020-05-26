Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0871AE058
	for <lists+linux-s390@lfdr.de>; Fri, 17 Apr 2020 17:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgDQPCG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 17 Apr 2020 11:02:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50713 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728271AbgDQPCF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Apr 2020 11:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587135724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zAUQ1fejVgK8xdiFLC8Kzo6yupRq84Rn11njknDDfkc=;
        b=UL6igtFdRjUqVX8dYUalCN6cR4o01K72amxBsbfHlONfYCbC+roKxFg7IWnRfPfhg+yBVH
        39Y6e0f3SuuoFIa79rzZpSUYA5sTVAEPVpv0lqZYnGht89+a1SxSksd2mvgNYduMkXfMr8
        ujo9wUqKi6vFPUwHuARQkD9Kv2Eyb3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-qKoBkKQ3NGO4Eh09TUhtLQ-1; Fri, 17 Apr 2020 11:01:59 -0400
X-MC-Unique: qKoBkKQ3NGO4Eh09TUhtLQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A34BE800D5C;
        Fri, 17 Apr 2020 15:01:57 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-107.ams2.redhat.com [10.36.114.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC3C8A09B9;
        Fri, 17 Apr 2020 15:01:52 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kirill Smelkov <kirr@nexedi.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH RFC 0/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK
Date:   Fri, 17 Apr 2020 17:01:49 +0200
Message-Id: <20200417150151.17239-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Looking into why we still create memblocks for hotplugged memory (via
add_memory()), I discovered that we might not need ARCH_KEEP_MEMBLOCK on
s390x after all.

After [1] we will no longer create memblocks for hotplugged memory in
case of !CONFIG_ARCH_KEEP_MEMBLOCK. With this series, the same will apply
to standby memory on s390x, added via add_memory().

[1] https://lkml.kernel.org/r/20200416104707.20219-1-david@redhat.com

David Hildenbrand (2):
  s390/zcore: traverse resources instead of memblocks
  s390/mm: don't set ARCH_KEEP_MEMBLOCK

 arch/s390/Kconfig         |  1 -
 drivers/s390/char/zcore.c | 61 ++++++++++++++++++++++++++++++---------
 2 files changed, 48 insertions(+), 14 deletions(-)

--=20
2.25.1

