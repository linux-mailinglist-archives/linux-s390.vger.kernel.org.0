Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E42721549EB
	for <lists+linux-s390@lfdr.de>; Thu,  6 Feb 2020 18:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgBFRD4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 6 Feb 2020 12:03:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39503 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727773AbgBFRD4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Feb 2020 12:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581008635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZ+wCDHlpmj2MEIpeb0HAQG2PkMc60gWNqQ5c6sbTrw=;
        b=aZsfbSc0wLpvWnhKN7dsWxjNQ94mKB0eTEbHt8TIRZT09Lz3zaUrQk7o6GTQO7I3qi0xXr
        BlyHb+91EtMIBIb4JZ4CiFZchx51Me/GK84h+C6o/x47y8+3bn7i4EY62ckT2Zm+mQspuN
        IEWGsotxXBypfKLEnB/7I/I9EPsN7UQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-mAVvcrbBMauYviiyOp0GoA-1; Thu, 06 Feb 2020 12:03:37 -0500
X-MC-Unique: mAVvcrbBMauYviiyOp0GoA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 731FA1835A24;
        Thu,  6 Feb 2020 17:03:35 +0000 (UTC)
Received: from localhost (dhcp-192-195.str.redhat.com [10.33.192.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D45348;
        Thu,  6 Feb 2020 17:03:34 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Nishad Kamdar <nishadkamdar@gmail.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 1/1] vfio-ccw: Use the correct style for SPDX License Identifier
Date:   Thu,  6 Feb 2020 18:03:31 +0100
Message-Id: <20200206170331.1032-2-cohuck@redhat.com>
In-Reply-To: <20200206170331.1032-1-cohuck@redhat.com>
References: <20200206170331.1032-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Nishad Kamdar <nishadkamdar@gmail.com>

This patch corrects the SPDX License Identifier style in
header file related to S/390 common i/o drivers.
It assigns explicit block comment to the SPDX License
Identifier.

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Fixes: 3cd90214b70f ("vfio: ccw: add tracepoints for interesting error pa=
ths")
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
Message-Id: <20191225122054.GA4598@nishad>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_cc=
w_trace.h
index 30162a318a8a..f5d31887d413 100644
--- a/drivers/s390/cio/vfio_ccw_trace.h
+++ b/drivers/s390/cio/vfio_ccw_trace.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Tracepoints for vfio_ccw driver
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Tracepoints for vfio_ccw driver
  *
  * Copyright IBM Corp. 2018
  *
--=20
2.21.1

