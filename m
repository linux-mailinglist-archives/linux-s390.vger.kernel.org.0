Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70ACD1549EE
	for <lists+linux-s390@lfdr.de>; Thu,  6 Feb 2020 18:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBFRED (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 6 Feb 2020 12:04:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56994 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726990AbgBFRED (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Feb 2020 12:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581008642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Cqvvo15drJ21tIHO7yPlH0D47TYDD5oK5I3gU6dSTkg=;
        b=hYWnI251c/tvW7GIOJ0Jlrtp+jduzfw2bYFWlkTL5c1iu4My3/h+ok9C5Z14jFJM3R2SbZ
        Yz/NHPKJJ7aM4SnIFgyJ5+1J+W9Ukc04g/HHg4p2iwT/KMogncSjc1c83jcRzPxkYAxtI4
        a4D0h+n6WCiuhUmVwRpfSfR24xdYIHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-2cKMQzVAPnCQm3lMtviSag-1; Thu, 06 Feb 2020 12:03:35 -0500
X-MC-Unique: 2cKMQzVAPnCQm3lMtviSag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95A3F8010D6;
        Thu,  6 Feb 2020 17:03:33 +0000 (UTC)
Received: from localhost (dhcp-192-195.str.redhat.com [10.33.192.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 407E95C1B0;
        Thu,  6 Feb 2020 17:03:33 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/1] one vfio-ccw patch for 5.6
Date:   Thu,  6 Feb 2020 18:03:30 +0100
Message-Id: <20200206170331.1032-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa9=
19:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git ta=
gs/vfio-ccw-20200206

for you to fetch changes up to dbaf10027ae92a66f0dfad33e1e3453daa16373f:

  vfio-ccw: Use the correct style for SPDX License Identifier (2020-01-07=
 10:37:34 +0100)

----------------------------------------------------------------
fix style of SPDX License Identifier

----------------------------------------------------------------

Nishad Kamdar (1):
  vfio-ccw: Use the correct style for SPDX License Identifier

 drivers/s390/cio/vfio_ccw_trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
2.21.1

