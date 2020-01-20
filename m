Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8311428C7
	for <lists+linux-s390@lfdr.de>; Mon, 20 Jan 2020 12:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgATLE0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 20 Jan 2020 06:04:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33899 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726465AbgATLEZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jan 2020 06:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579518265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gy1QgF8VJlA5zD6ybpuYbV4sRYlFxGtF/MSXbawP5Hk=;
        b=Si9LXUvCMTYliz4dNbxmxWXhLLulACoNA27zbuw4e+cxUTGdp2yUxYVKSCLF+7QSkGkjz4
        H/EDhHTwp1sUWctKluoqzqqkPG2U12rT/kvJjmjR7MNIu7VMH6SlD/NJB2FMFAbTYMbqLD
        aQy5VOdXYrPB6TIp6q9kBoblEHnSKDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-e39AIbXLN1eNTopVvNTfHw-1; Mon, 20 Jan 2020 06:04:21 -0500
X-MC-Unique: e39AIbXLN1eNTopVvNTfHw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 718BA10054E3;
        Mon, 20 Jan 2020 11:04:20 +0000 (UTC)
Received: from gondolin (ovpn-205-161.brq.redhat.com [10.40.205.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E8AC5C21A;
        Mon, 20 Jan 2020 11:04:16 +0000 (UTC)
Date:   Mon, 20 Jan 2020 12:04:13 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, david@redhat.com
Subject: Re: [kvm-unit-tests PATCH v3 5/9] s390x: smp: Wait for cpu setup to
 finish
Message-ID: <20200120120413.48b6703a.cohuck@redhat.com>
In-Reply-To: <20200117104640.1983-6-frankja@linux.ibm.com>
References: <20200117104640.1983-1-frankja@linux.ibm.com>
        <20200117104640.1983-6-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 17 Jan 2020 05:46:36 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> We store the user provided psw address into restart new, so a psw
> restart does not lead us through setup again.
> 
> Also we wait on smp_cpu_setup() until the cpu has finished setup
> before returning. This is necessary for z/VM and LPAR where sigp is
> asynchronous.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  lib/s390x/smp.c  | 2 ++
>  s390x/cstart64.S | 2 ++
>  2 files changed, 4 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

