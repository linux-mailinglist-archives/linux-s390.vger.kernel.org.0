Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 388D612050C
	for <lists+linux-s390@lfdr.de>; Mon, 16 Dec 2019 13:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfLPMJa (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 16 Dec 2019 07:09:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24613 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727383AbfLPMJa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 16 Dec 2019 07:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576498169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8VqSQFp6ED8yxTCSwQq9is0NdfhssmYgcirrk4juMv4=;
        b=NM4Le3mHnmgTc8AoRpJ3A0wT6+3qAIEKJr9cynyB8w1VxrVdPlm7ESfX/gPDXLbDuIluBf
        CT2T/Q6Nrnbl1Mj4Pi3wTyPWGW9fyULsgrOA9vb4KwM1xHvZk9rXi64EV5vUoS8QbNhdkm
        /vU3nlrlfVOmkU07WUs1yfKSp8YXfkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-HzxbTRaGMm6A5HUi8SYi8w-1; Mon, 16 Dec 2019 07:09:25 -0500
X-MC-Unique: HzxbTRaGMm6A5HUi8SYi8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FBA28005B3;
        Mon, 16 Dec 2019 12:09:24 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D0A27C815;
        Mon, 16 Dec 2019 12:09:22 +0000 (UTC)
Date:   Mon, 16 Dec 2019 13:09:20 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
        Stefan Haberland <sth@linux.ibm.com>, qemu-s390x@nongnu.org,
        psundara@redhat.com,
        Jan =?UTF-8?B?SMO2cHBuZXI=?= <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [RFC QEMU PATCH] pc-bios/s390-ccw: Add zipl-like "BOOT_IMAGE=x"
 to the kernel parameters
Message-ID: <20191216130920.42711f32.cohuck@redhat.com>
In-Reply-To: <ffea8f68-714b-798e-3563-12f9bf0668fa@de.ibm.com>
References: <20191216112432.13412-1-thuth@redhat.com>
        <ffea8f68-714b-798e-3563-12f9bf0668fa@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 16 Dec 2019 12:29:24 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 16.12.19 12:24, Thomas Huth wrote:
> >  Note: I've marked the patch as RFC since I'm not quite sure whether
> >  this is really the right way to address this issue: It's unfortunate
> >  that we have to mess with different location in ZIPL which might also
> >  change again in the future. As suggested by Christian on IRC last week,
> >  maybe it would make more sense to change ZIPL to add this parameter
> >  already when zipl is installed (i.e. by the Linux userspace "zipl" pro-
> >  gram), instead of adding it during boot time? Also, the BOOT_IMAGE para-
> >  meter on s390x is quite different from the BOOT_IMAGE paramter that is
> >  used on x86 - while s390x only uses one single number here, the x86
> >  variant (added by grub2, I guess) uses the boot device + full filename
> >  of the kernel on the boot partition. Should we maybe make the s390x
> >  variant more conform to x86? If so, I think this really has to be fixed
> >  in zipl userspace tool, and not in the s390-ccw bios (and zipl stage3
> >  bootloader).  
> 
> Yes, I actually think we should revisit the whole BOOT_IMAGE scheme on s390.
> Maybe we should use the kernel name, or the name of the boot menu entry.
> And maybe we should not use 0 (when the default is running) but instead
> really use to what 0 points to.

Probably dumb question: Is booting via the s390-ccw bios the only time
we boot without going through zipl? What about e.g. booting from the
reader under z/VM? There's probably no BOOT_IMAGE= statement there,
either?

