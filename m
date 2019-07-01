Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50FE030C0B
	for <lists+linux-s390@lfdr.de>; Fri, 31 May 2019 11:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfEaJvB (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 31 May 2019 05:51:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfEaJvB (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 May 2019 05:51:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5305230C0DCA;
        Fri, 31 May 2019 09:51:01 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 349C57AB62;
        Fri, 31 May 2019 09:50:58 +0000 (UTC)
Date:   Fri, 31 May 2019 11:50:55 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1] s390/pkey: Use -ENODEV instead of -EOPNOTSUPP
Message-ID: <20190531115055.7f5cf64e.cohuck@redhat.com>
In-Reply-To: <20190531093628.14766-1-david@redhat.com>
References: <20190531093628.14766-1-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 31 May 2019 09:51:01 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 31 May 2019 11:36:28 +0200
David Hildenbrand <david@redhat.com> wrote:

> systemd-modules-load.service automatically tries to load the pkey module
> on systems that have MSA.
> 
> Pkey also requires the MSA3 facility and a bunch of subfunctions.
> Failing with -EOPNOTSUPP makes "systemd-modules-load.service" fail on
> any system that does not have all needed subfunctions. For example,
> when running under QEMU TCG (but also on systems where protected keys
> are disabled via the HMC).
> 
> Let's use -ENODEV, so systemd-modules-load.service properly ignores
> failing to load the pkey module because of missing HW functionality.
> 
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/s390/crypto/pkey_api.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Looking at what other modules return when needed features are missing,
this looks like the right thing to do.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
