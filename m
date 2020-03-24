Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B746190DE5
	for <lists+linux-s390@lfdr.de>; Tue, 24 Mar 2020 13:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgCXMpp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 24 Mar 2020 08:45:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49536 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727379AbgCXMpp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 08:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585053944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sSwimgKy5/2wLztTXvka1CeqX41h3J5vWALZ762lcU=;
        b=gIw7jY+3ydCSXawPyXJNsQGVW6/4aN0doG1AGWn1veDq02iNtmjEd1YZSvUa4RJJrk00iI
        nF18FcTG5/JfJ3+ZFRGVV0pSqdohWQlupdiYx6EBYarNTRD3lWlV4OGajwea+XgR8uC0HT
        Dbr5CuP3Oy+NH3DSRVO1Xy2HDAR9bGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-GS4xzUMONyeO78-cB21LLg-1; Tue, 24 Mar 2020 08:45:40 -0400
X-MC-Unique: GS4xzUMONyeO78-cB21LLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81A65108839D;
        Tue, 24 Mar 2020 12:45:38 +0000 (UTC)
Received: from gondolin (ovpn-113-109.ams2.redhat.com [10.36.113.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA191100EBB1;
        Tue, 24 Mar 2020 12:45:21 +0000 (UTC)
Date:   Tue, 24 Mar 2020 13:45:19 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org,
        david@redhat.com
Subject: Re: [kvm-unit-tests PATCH 09/10] s390x: smp: Add restart when
 running test
Message-ID: <20200324134519.50664590.cohuck@redhat.com>
In-Reply-To: <20200324081251.28810-10-frankja@linux.ibm.com>
References: <20200324081251.28810-1-frankja@linux.ibm.com>
        <20200324081251.28810-10-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 24 Mar 2020 04:12:50 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's make sure we can restart a cpu that is already running.
> Restarting it if it is stopped is implicitely tested by the the other
> restart calls in the smp test.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

