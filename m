Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9624C1B3993
	for <lists+linux-s390@lfdr.de>; Wed, 22 Apr 2020 10:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgDVIFw (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 22 Apr 2020 04:05:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59068 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725786AbgDVIFv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 22 Apr 2020 04:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587542751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4MyHijEyJpWGM/c98uFFlOcGKHeKKrBeaPb73JuPQs=;
        b=WYT6fE1Cv0Fy53jXNqKRtI2h1fnx+sNn2eQ0UZac30+LGHnPTdtGS/DRMqZswZ4lIcjzx3
        mTVmw0I1HkLdckErDIeP6M5PwjgqIIwSwouwUxTZzhnf5QlhqhbW0Pws4pyVMvXY5Q1rjx
        iIqyC/OVQ8Elo6n6Q7BgO6PMnmdEN2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-zUa0EviTMAKDoXoFBXtj8A-1; Wed, 22 Apr 2020 04:05:47 -0400
X-MC-Unique: zUa0EviTMAKDoXoFBXtj8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3438D107ACC4;
        Wed, 22 Apr 2020 08:05:46 +0000 (UTC)
Received: from gondolin (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17F73B3A76;
        Wed, 22 Apr 2020 08:05:41 +0000 (UTC)
Date:   Wed, 22 Apr 2020 10:05:39 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v5 05/10] s390x: export the clock
 get_clock_ms() utility
Message-ID: <20200422100539.5a4f3a2f.cohuck@redhat.com>
In-Reply-To: <1582200043-21760-6-git-send-email-pmorel@linux.ibm.com>
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
        <1582200043-21760-6-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 20 Feb 2020 13:00:38 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Let's move get_clock_ms() to lib/s390/asm/time.h, so it can be used in
> multiple places.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/time.h | 26 ++++++++++++++++++++++++++
>  s390x/intercept.c    | 11 +----------
>  2 files changed, 27 insertions(+), 10 deletions(-)
>  create mode 100644 lib/s390x/asm/time.h

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

