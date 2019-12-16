Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB3B12054D
	for <lists+linux-s390@lfdr.de>; Mon, 16 Dec 2019 13:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfLPMSc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 16 Dec 2019 07:18:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35730 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727481AbfLPMSb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Dec 2019 07:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576498710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=cqaJdP3TtA73S+4ncJOjEYsMFzUZZevQNaQZ+pj7Qs4=;
        b=D84JVSoSUVljPUXJt0LWHL5J/4b2CGI08Mh/wr6VKEUxREsYLI0GbEBlGSsLJvzuvftcsb
        6hldLXN73SLNR2dV9E2dCCz6P3sQaoJCcFoSBwfAy3fS5XQzaGqQ4US+EUcfoBd9nn79xy
        tPcLfu34vsgvQxe2CNT++xof792OJOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-_dXcjtlyNyuub8N3DZ72ZQ-1; Mon, 16 Dec 2019 07:18:26 -0500
X-MC-Unique: _dXcjtlyNyuub8N3DZ72ZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1FC1800D4C;
        Mon, 16 Dec 2019 12:18:24 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-164.ams2.redhat.com [10.36.117.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F170610001B3;
        Mon, 16 Dec 2019 12:18:22 +0000 (UTC)
Subject: Re: [RFC QEMU PATCH] pc-bios/s390-ccw: Add zipl-like "BOOT_IMAGE=x"
 to the kernel parameters
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     qemu-devel@nongnu.org, Stefan Haberland <sth@linux.ibm.com>,
        qemu-s390x@nongnu.org, psundara@redhat.com,
        =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20191216112432.13412-1-thuth@redhat.com>
 <ffea8f68-714b-798e-3563-12f9bf0668fa@de.ibm.com>
 <20191216130920.42711f32.cohuck@redhat.com>
 <aab20f72-6350-b5a7-5bb0-e068b37bd766@de.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <80cbf5b0-ffbd-688f-8733-58dace78faab@redhat.com>
Date:   Mon, 16 Dec 2019 13:18:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <aab20f72-6350-b5a7-5bb0-e068b37bd766@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 16/12/2019 13.15, Christian Borntraeger wrote:
[...]
> I just learned from Peter that booting SCSI also has no BOOT_IMAGE (as
> we have no menu). So Thomas, can you find out the use case for the initial
> bug report.  That might give an indication on how to proceed for all cases.

Apparently this parameter is used by Dracut, see:

https://bugzilla.redhat.com/show_bug.cgi?id=1782026#c4

 Thomas

